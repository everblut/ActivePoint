load 'tasks/winnower.rb'
require 'thinreports'

namespace :evaluator do

  desc "Realiza los reportes pendientes y genera los archivos"
  task :create_reports => :environment do
  	Homework.needing_report.each do |homework|
  		perform_winnower(homework.id)
  		homework.update_attribute(:need_report,false)
  	end
  end

  desc "Crea un reporte tipo kardex por grupo"
  task :create_kardex => :environment do
    Course.needing_report.each do |course|
      hw_count = course.homeworks.count
      puts "Cantidad de tareas: #{hw_count}"
      kardex = {}
      hws = homeworks_per course
      hws.each do |h|
        h[1].each { |m| kardex[m[0]] = inc_counter(kardex,m[0]) }
      end
      folder =  Rails.root.join("public")
      r_name = "/uploads/#{course.teacher.id}/#{course.id}/kardex.pdf"
      report_name =  "#{folder}#{r_name}"
      puts "creando reporte... #{report_name}"
      create_kardex(kardex,course.name,report_name,hw_count)
    end
  end
  def homeworks_per course
    hws = {}
    course.homeworks.each { |hw| hws[hw.name] = exercise_per(hw) }
    return hws
  end
  def exercise_per homework
    counts = {}
    homework.exercises.each { |ex| counts[ex.name] = inc_counter(counts,ex.name) }
    return counts
  end
  def inc_counter counts, name
    counts[name].nil? ? 1 : counts[name] + 1
  end
  def perform_winnower(homework_id)
  	homework = Homework.find(homework_id)
  	course = homework.course
  	teacher = course.teacher
  	exercises = homework.exercises
  	path = Rails.root.join("public", "uploads","#{teacher.id}","#{course.id}","#{homework.id}")
  	files = Dir.glob("#{path}/*/*")
  	puts "Comparando #{files.count}\nPara la tarea #{homework.name} del curso #{course.name}"
  	win = Winnower.new(15,10,path)
  	win.execute
  	folder =  Rails.root.join("public")
  	r_name = "/uploads/reports/#{teacher.name}-#{course.name}-#{homework.name}.pdf".gsub(" ","_")
  	report_name =  "#{folder}#{r_name}"
  	puts "Generando el reporte con nombre : #{report_name}"
    plot = create_plot(report_name,win)
  	generate_report(win, prepare_info(teacher,homework,course,report_name),plot)
  	r = Report.find_by(homework_id: homework.id)
  	r.destroy unless r.nil?
  	Report.create({name: r_name, homework_id: homework.id})
  end

  def create_plot(name,win)
      plot_name = name.split(".")[0] + ".plot"
      outputname = name.split(".")[0] + ".png"
      puts "creando archivo con nombre #{plot_name}"
      File.open(plot_name,'w+') do |file|
        win.filenames.combination(2) do |filenames|
          matricula1 = File.basename(filenames[0],'.*')
          matricula2 = File.basename(filenames[1],'.*')
          value = ""
          index_x = 0
          index_y = 0
          key = "#{matricula1}-#{matricula2}"
          index_x = win.filenames.index(filenames[0])+1
          index_y = win.filenames.index(filenames[1])+1
          average = win.averages[key]
          file.write("#{index_x} #{index_y} #{average.to_i*1} #{matricula1} #{matricula2}")
          file.write("\n")
          yek = "#{matricula2}-#{matricula1}"
          index_x = win.filenames.index(filenames[1])+1
          index_y = win.filenames.index(filenames[0])+1
          average = win.averages.has_key?(yek) ? win.averages[yek] : win.averages[key]
          file.write("#{index_x} #{index_y} #{average.to_i*1} #{matricula2} #{matricula1}")
          file.write("\n")
        end
        win.filenames.each_with_index do |filename,index|
          matricula = File.basename(filename,'.*')
          file.write("#{index} #{index+1} 100 #{matricula} #{matricula}")
          file.write("\n")
        end
      end
      plotter_loc = "#{Rails.root.join('lib')}/plotter"
      gp = "#{plotter_loc}.gp"
      plotter_loc = "#{plotter_loc}.sh"
      puts "plotter en > #{plotter_loc}"
      %x{bash #{plotter_loc} '#{gp}' '#{plot_name}' '#{outputname}'}
      return outputname
  end

  def prepare_info(teacher,homework,course,reporte)
    { :nom_mae => "Para : #{teacher.name}",
        :nom_eje => "#{homework.name}",
        :nom_mate => "#{course.name}",
	       :report_name => reporte
    }
  end
  def generate_report(w, info, heatmap)
  	layout = Rails.root.join("lib","assets")
    report = ThinReports::Report.new layout: "#{layout}/report.tlf"
    report.events.on :page_create do |e|
    	e.page.item(:pnum).value(e.page.no)
    end
    report.events.on :generate do |e|
      e.pages.each do |page|
      	page.item(:ptotal).value("/ #{e.report.page_count}")
      end
    end
  	report.start_new_page do |page|
  		page.item(:nom_mae).value(info[:nom_mae])
  		page.item(:nom_eje).value(info[:nom_eje])
  		page.item(:nom_mate).value(info[:nom_mate])
  		page.item(:arch).hide
  		page.item(:arc).show
  		page.item(:ymb).hide
  		page.item(:sim).hide
  		w.files.keys.each do |filename|
  			page.list.add_row do |row|
  				row.item(:nam).value("#{filename}")
  				row.item(:y).hide
  			end
  		end
  	end
  	report.start_new_page do |page|
  		page.item(:nom_mae).value(info[:nom_mae])
  		page.item(:nom_eje).value(info[:nom_eje])
  		page.item(:nom_mate).value(info[:nom_mate])
  		page.item(:arc).hide
   		w.averages.sort_by(&:last).reverse.each_with_index do |key,index|
   			k1,k2 = key[0].split("-")
  			page.list.add_row do |row|
  				row.item(:no).value("#{index+1}")
  				row.item(:matricula1).value("#{k1}")
  				row.item(:matricula2).value("#{k2}")
  				row.item(:percent).value("#{(key[1]*1).to_i}%")
  			end
  		end
  	end
    report.start_new_page do |page|
      page.item(:arch).hide
      page.item(:arc).hide
      page.item(:ymb).hide
      page.item(:sim).hide
      page.item(:plot).src(heatmap)
      page.item(:plot).show
    end
  	report.generate(filename: info[:report_name])
    %x{rm '#{heatmap}'}
  end
  def create_kardex(kardex,nom_mate,report_name,hw_total)
    layout = Rails.root.join("lib","assets")
    report = ThinReports::Report.new layout: "#{layout}/kardex.tlf"
    report.events.on :page_create do |e|
      e.page.item(:pnum).value(e.page.no)
    end
    report.events.on :generate do |e|
      e.pages.each do |page|
        page.item(:ptotal).value("/ #{e.report.page_count}")
      end
    end
    report.start_new_page do |page|
      page.item(:nom_mate).value(nom_mate)
      kardex.each do |student|
        page.list.add_row do |row|
          row.item(:mat).value("#{student[0]}")
          row.item(:percent).value("#{student[1]} de #{hw_total}")
        end
      end
    end
    report.generate(filename: report_name)
  end

end
