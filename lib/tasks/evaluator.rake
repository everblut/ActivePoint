load 'Winnower.rb'
require 'thinreports'

namespace :evaluator do

  desc "Realiza los reportes pendientes y genera los archivos"
  task :create_reports => :environment do
  	Homework.needing_report.each do |homework|
  		perform_winnower(homework.id)
  		homework.update_attribute(:need_report,false)
  	end
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
  	generate_report(win, prepare_info(teacher,homework,course,report_name))
  	r = Report.find_by(homework_id: homework.id)
  	r.destroy unless r.nil?
  	Report.create({name: r_name, homework_id: homework.id})
  end

def prepare_info(teacher,homework,course,reporte)
    { :nom_mae => "Para : #{teacher.name}",
        :nom_eje => "#{homework.name}",
        :nom_mate => "#{course.name}",
	:report_name => reporte
    }
end
def generate_report(w, info)
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
	report.generate(filename: info[:report_name])
end

end
