class OpenFlashChart
  def initialize
    @data					 = []
		@x_labels			 = []
		@y_min				 = 0
		@y_max				 = 20
		@y_label_steps = 5
		@title				 = ""
		@title_style   = ""
		@title_size		 = 30
		@x_tick_size	 = -1
		@y2_max				 = ''
		@y2_min				 = ''

		# GRID styles
		@y_axis_color	= @x_axis_color = @x_grid_color	= @y_grid_color = ""
		@x_axis_3d    = ''
		@x_axis_steps	= -1
		@y2_axis_color
		
		# AXIS LABEL styles
		@x_label_style						 = ''
		@y_label_style 						 = ''
		@y_label_style_right			 = ''

		# AXIS LEGEND styles
		@x_legend				= ''
		@y_legend				= ''
		@y_legend_right = ''
		
		@lines				= []
		@y2_lines			= []
    @line_default = "&line=3,#87421F" + "& \n"
	
		@bg_color	= ''
		@bg_image = ''

		@inner_bg_color	  = ''
		@inner_bg_color_2 = ''
		@inner_bg_angle   = ''

    # PIE chart
		@pie        = ''
		@pie_values = ''
		@pie_colors = ''
		@pie_labels = ''

		@tool_tip   = ''
  end

  def set_data(data)
    if @data.size == 0
      @data << '&values=' + data.join(',') + "& \n"
    else
      @data << '&values_' + (@data.size + 1).to_s + "=" + data.join(',') + "& \n"
    end
  end

	# create the set methods for these instance variables in a loop since they are all the same
	%w(tool_tip x_labels bg_color y_max y_min y_label_steps x_tick_size x_axis_steps x_axis_3d).each do |method|
		define_method("set_#{method}") do |a|
			self.instance_variable_set("@#{method}", a)
		end
	end

	def set_x_label_style(size, color='', orientation=0, step=-1, grid_color='')
		@x_label_style  = "&x_label_style=#{size}"
		@x_label_style += ",#{color}" 			if color.size > 0
		@x_label_style += ",#{orientation}" if orientation > -1
		@x_label_style += ",#{step}" 				if step > 0
		@x_label_style += ",#{grid_color}"  if grid_color.size > 0

	end

	def set_bg_image(url, x='center', y='center')
		@bg_image 	= url
		@bg_image_x = x
		@bg_image_y = y
	end

	def attach_to_y_right_axis(data_number)
  	@y2_lines << data_number
	end

	def set_inner_background(col, col2='', angle=-1)
		@inner_bg_color  = col
		@inner_bg_color2 = col2  if col2.size > 0
		@inner_bg_angle  = angle if angle != -1
	end

	%w(y_label_style y_right_label_style).each do |method|
  	define_method("set_#{method}") do |size, color|
			color ||= ''
			temp = "&#{method}=" + size.to_s
			temp += "," + color if color.size > 0
			temp += "& \n"
			self.instance_variable_set("@#{method}", temp)
    end
	end

	%w(max min).each do |m|
 		define_method("set_y_right_#{m}") do |x|
			temp = "&y2_#{m}=#{x}& \n"
  		self.instance_variable_set("@y2_#{m}", temp)
		end
	end

	def title(title, style='')
		@title       = title
		@title_style = style  if style.size > 0
	end

	%w(x_legend y_legend y_right_legend).each do |method|
 		define_method("set_" + method) do |text, size, color| 
			size  ||= -1
			color ||= ''
			# next three lines will only be needed if defining y_rigth_legend
			method  = "y_legend_right" if method =~ /right/
			label		= method
			label		= "y2_legend" if method =~ /right/
    	self.instance_variable_set("@#{method}", "&#{label}=#{text}")
    	self.instance_variable_set("@#{method}" + "_size", size) if size > 0
    	self.instance_variable_set("@#{method}" + "_color", color) if color.size > 0
		end
	end

	def line(width, color='', text='', size=-1, circles=-1)
		temp  = '&line'
		temp += '_' + (@lines.size + 1).to_s if @lines.size > 0
		temp += '='
		temp += width.to_s			    if width > 0
		temp += ',' + color 		    if width > 0
		temp += ',' + text          if text.size > 0
		temp += ',' + size.to_s     if text.size > 0
		temp += ',' + circles.to_s 	if circles > 0
		temp += "& \n"

		@lines << temp
	end

	%w(line_dot line_hollow).each do |method|
		define_method(method) do |width, dot_size, color, text, font_size|
			text ||= ''
			font_size ||= ''
			temp  = "&#{method}"
			temp += '_' + (@lines.size + 1).to_s if @lines.size > 0
			temp += "=#{width},#{color},#{text}"
			temp += ",#{font_size},#{dot_size}" if font_size.size > 0
			temp += "& \n"

			@lines << temp
		end
	end

	def area_hollow(width, dot_size, color, alpha, text='', font_size='')
		temp  = "&area_hollow"
		temp += '_' + (@lines.size + 1).to_s if @lines.size > 0
		temp += "=#{width},#{dot_size},#{color},#{alpha}"
		temp += ",#{text},#{font_size}" if text.size > 0
		temp += "& \n"

		@lines << temp
	end


	%w(bar bar_3d bar_fade).each do |method|
		define_method(method) do |alpha, color, text, size|
			text ||= ""
			size ||= -1
			temp  = "&#{method}"
			temp += "_" + (@lines.size + 1).to_s if @lines.size > 0
			temp += "="
			temp += "#{alpha},#{color},#{text},#{size}"
			temp += "& \n"
			
			@lines << temp
		end
	end

	%w(bar_glass bar_filled).each do |method|
		define_method(method) do |alpha, color, color_outline, text, size|
			text ||= ""
			size ||= -1
			method = "filled_bar" if method == "bar_filled"
			temp  = "&#{method}"
			temp += "_" + (@lines.size + 1).to_s if @lines.size > 0
			temp += "="
			temp += "#{alpha},#{color},#{color_outline},#{text},#{size}"
			temp += "& \n"
    @lines << temp

		end
	end

	%w(x y).each do |method|
  	define_method(method + "_axis_color") do |axis, grid|
			grid ||= ''
    	self.instance_variable_set("@#{axis}_axis_color", axis)
    	self.instance_variable_set("@#{axis}_grid_color", grid)
		end
	end

	def pie(alpha, line_color, label_color)
		@pie = "#{alpha},#{line_color},#{label_color}"
	end

	def pie_values(values, labels)
		@pie_values = values.join(',')
		@pie_labels = labels.join(',')
	end

	def pie_slice_colors(colors)
		@pie_colors = colors.join(",")
	end

	def render
  	temp  = ""

		{"title" 					=> [@title, @title_style],
		 "x_legend"				=> [@x_legend, @x_legend_size, @x_legend_color],
		 "x_ticks"				=> [@x_tick_size],
		 "x_axis_steps"   => [@x_axis_steps, @x_axis_3d],
		 "bg_colour" 			=> [@bg_color],
  	 "tool_tip"				=> [@tool_tip]
		}.each do |k,v|
			next if (v[0].class == String ? v[0].size <= 0 : v[0] <= 0)
    	temp += "&#{k}="
			temp += v.join(",")
			temp += "& \n"
		end

		temp += @x_label_style if @x_label_style.size > 0

		%w(y_legend y_legend_right).each do |x|
    	temp += self.instance_variable_get("@#{x}")
		end

		temp += "&y_ticks=5,10," + "#{@y_label_steps}& \n"

		if @lines.size == 0
			temp += @line_default
		else
			temp += @lines.to_s
		end

		temp += @data.to_s

		if @y2_lines.size > 0
    	temp += "&y2_lines="
			temp += @y2_lines.join(",")
			temp += "& \n"
			temp += "&show_y2=true& \n"
		end

		temp += "&x_labels=#{@x_labels.join(',')}& \n" if @x_labels.size > 0

		temp += "&y_min=#{@y_min}& \n"
		temp += "&y_max=#{@y_max}& \n"

		if @bg_image.size > 0
			temp += "&bg_image=#{@bg_image}& \n"
			temp += "&bg_image_x=#{@bg_image_x}& \n"
			temp += "&bg_image_y=#{@bg_image_y}& \n"
		end

		%w(x y).each do |axis|
    	if self.instance_variable_get("@#{axis}_axis_color").size > 0
				temp += "&#{axis}_axis_colour=#{self.instance_variable_get("@#{axis}_axis_color")}& \n"
				temp += "&#{axis}_grid_colour=#{self.instance_variable_get("@#{axis}_grid_color")}& \n"
				temp += "&#{axis}2_axis_colour=#{self.instance_variable_get("@#{axis}2_axis_color")}& \n" if axis == 'y'
			end
		end
		if @inner_bg_color.size > 0
   		temp += "&inner_background=#{@inner_bg_color}"
			if @inner_bg_color_2.size > 0
				temp += "," + @inner_bg_color_2
				temp += "," + @inner_bg_angle
			end
			temp += "& \n"
		end

		if @pie.size > 0
    	temp += "&pie=#{@pie}& \n"
    	temp += "&values=#{@pie_values}& \n"
    	temp += "&pie_labels=#{@pie_labels}& \n"
    	temp += "&colours=#{@pie_colors}& \n"
		end

		return temp
	end

  def self.swf_object(width, height, url)
    url     = CGI::escape(url)
    output  = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0\" width=\"#{width}\" height=\"#{height}\" id=\"graph\" align=\"middle\">"
    output += '<param name="allowScriptAccess" value="sameDomain" />'
    output += "<param name=\"movie\" value=\"/open-flash-chart.swf?width=#{width.to_s} &height=#{height.to_s} &data=#{url}\" /><param name=\"quality\" value=\"high\" /><param name=\"bgcolor\" value=\"#FFFFFF\" />"
    output += '<embed src="/open-flash-chart.swf?width=' + width.to_s + '&height=' + height.to_s + '&data=' + url.to_s + '" quality="high" bgcolor="#FFFFFF" width="' +  width.to_s + '" height="' + height.to_s + '" name="open-flash-chart" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'
    output += '</object>'
		return output
  end
end
