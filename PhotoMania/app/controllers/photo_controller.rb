class PhotoController < ApplicationController

	def showcover
		u=User.find(session[:user].id)
		a=u.find(params[:data])
		p=a.last
		pics=""
		if p
		pics='<img src="data:image/gif;base64,'+p.binary_data+'" width="200" height="200" id="'+"#{p.id}"+'" />'
		end
		send_data(pics,:type => "text/html");
	end
	def upload
		if params[:image_file].content_type=="image/jpeg" || params[:image_file].content_type=="image/png"
		if params[:aname]==nil || params[:aname]=="" || params[:image_file]==nil || params[:image_file].original_filename==""
			respond_to do |format|
			format.html {redirect_to(users_path)}
			end
		else
		@u=User.find(session[:user].id)
		a=params[:aname]
		input=params[:image_file]
		@b=@u.albums.find_by_aname(a)
		if(!@b)
		   @b=@u.albums.create(:aname=>a)
		end
		pic=@b.photos.new
		pic.filename=input.original_filename
		pic.content_type=input.content_type.chomp
		pic.binary_data=Base64.encode64(input.read)
		pic.description=params[:description]
		if pic.save
			note="saved"
		else
			note="not Saved"
		end
		respond_to do |format|
			session[:athome]=1
			format.html {redirect_to(users_path,:notice=>note)}
		end
		end
		else
			respond_to do |format|
			session[:athome]=1
			format.html {redirect_to(users_path)}
			end
		end
	end
	def show1 
  		@image_data = Photos.find(params[:id])
			if(@image_data)
  			@image = @image_data.binary_data
  			send_data(@image,:type=>@image_data.content_type,:filename => @image_data.filename, :disposition => 'inline')
			else
			respond_to do |format|
			format.html {redirect_to(root_path,:notice=>"No Image yet")}
			end
			end
	end
	def rem
		a=Photo.find(params[:data]).album_id
		@u=User.find_by_email(session[:user].email)
		@a=@u.albums.find(a)
		Photo.delete(params[:data])
		render :json => {"response" => a}
	end
  	def showpics
		@u=session[:user]
		@a=@u.albums.find(params[:data])
		data=@a.photos.all
		pics="<br/><div style='position:relative;top:50px;left:350px; font-size:40px;color:#3F5765;'>"+@a.aname+"</div>"
		data.each do |d|
			pics+='<img style="margin-top:50px;" src="data:image/gif;base64,'+d.binary_data+'" width="150" height="150" id="'+"#{d.id}"+'" /><button type="button" style="position:relative;bottom:138px;right:27px;font-size:10px;margin-top:150px;"onclick="del(this.value)" value="'+"#{d.id}"+'" id="'+"#{d.id}"+'">'+"X"+'</button>'
		end	
		send_data(pics,:type => "text/html");
	end
	def products
			session[:athome]=nil
			data='<a href="/photoframes"><div class="p" id="frames"><strong><font size="8">Frames</font></strong><br/>Frame your special moments!!<br/><br/><img src="/frame.jpg" alt="abc" align="middle" width="200" height="250" /></div></a>'+'<a href="/photomugs"><div class="p"><font size="8">Photo <strong>Mugs</strong></font><br/>Frame your special moments!!<br/><br/><img src="/mug.jpg" align="middle" alt="abc" width="300" height="250" /></div></a>'+'<a href="/tshirts"><div class="p"><strong><font size="8">T-Shirts</font></strong><br/>Frame your special moments!!<br/><br/><img src="/tshirt.jpg" alt="abc" align="middle" width="200" height="250" /></div></a>'
			send_data(data,:type => "text/html"); 
	end

end
