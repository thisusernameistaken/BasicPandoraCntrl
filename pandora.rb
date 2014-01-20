require "gtk2"

class PandoraController < Gtk::Window

	def initialize
		super
		
		signal_connect "destroy" do 
            Gtk.main_quit 
        end
		
		fixed = Gtk::Fixed.new
		add fixed
		
		vol = "amixer sget Master | grep %"
		vol = `#{vol}`
		vols = vol.split(" ")
		currentVol = vols[4]
		currentVol= currentVol[1,currentVol.length-3].to_i
		
		slider = Gtk::HScale.new 0, 100, 1
		slider.set_size_request 475, 50
		slider.value = currentVol
		slider.signal_connect "value-changed" do
			cmd = "amixer set Master #{slider.value.to_i}%"
			cmd = `#{cmd}`
		end
		
		btnPlay = Gtk::Button.new "►/||"
		btnPlay.set_size_request 60, 30
		btnPlay.signal_connect "clicked" do
			cmdP = "echo -n 'p' > ~/.config/pianobar/ctl"
			cmdP = `#{cmdP}`
		end
		
		btnSkip = Gtk::Button.new "►►|"
		btnSkip.set_size_request 60, 30
		btnSkip.signal_connect "clicked" do
			cmdP = "echo -n 'n' > ~/.config/pianobar/ctl"
			cmdP = `#{cmdP}`
		end
		
		btnAdd = Gtk::Button.new "+"
		btnAdd.set_size_request 60, 30
		btnAdd.signal_connect "clicked" do
			cmdP = "echo -n '+' > ~/.config/pianobar/ctl"
			cmdP = `#{cmdP}`
		end
		
		btnSub = Gtk::Button.new "-"
		btnSub.set_size_request 60, 30
		btnSub.signal_connect "clicked" do
			cmdP = "echo -n '-' > ~/.config/pianobar/ctl"
			cmdP = `#{cmdP}`
		end
		
		btnQuit = Gtk::Button.new "Quit"
		btnQuit.set_size_request 60, 30
		btnQuit.signal_connect "clicked" do
			cmdP = "echo -n 'q' > ~/.config/pianobar/ctl"
			cmdP = `#{cmdP}`
		end
		
		txtStation = Gtk::Entry.new
		txtStation.set_size_request 60, 30
		
		
		btnStart = Gtk::Button.new "Change"
		btnStart.set_size_request 60, 30
		btnStart.signal_connect "clicked" do
			cmdP = "echo -n 's' > ~/.config/pianobar/ctl; sleep .5; echo '#{txtStation.text}' > ~/.config/pianobar/ctl;"
			cmdP = `#{cmdP}`
		end
		
		fixed.put btnPlay, 5,10
		fixed.put btnSkip, 75, 10
		fixed.put btnAdd, 145,10
		fixed.put btnSub, 215, 10
		fixed.put btnQuit, 285, 10
		fixed.put btnStart, 355, 10
		fixed.put txtStation, 425, 10
		fixed.put slider, 13, 40
		
		set_title "Pandora control"
		set_default_size 500, 100
		
		show_all
		
		
	end
end

Gtk.init 
	window = PandoraController.new
Gtk.main
