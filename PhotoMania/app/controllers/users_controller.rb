class UsersController < ApplicationController

def index
	if !session[:user]
		respond_to do |format|
			format.html {redirect_to(root_path)}
		end
	else
		respond_to do |format|
			session[:athome]=1
			format.html
		end
	end
end
def home
	respond_to do |format|
	if session[:user]==nil
	format.html
	else
	session[:athome]=1
	format.html {redirect_to(users_path)}
	end
	end
end
def signup
	a=params[:uname]
	b=params[:pwd1]
	c=params[:pwd2]
	if a==nil || b==nil || c==nil || a=="" || b=="" || c==""
		respond_to do |format|
			format.html {redirect_to(root_path)}
		end
	else
	if b!=c
		respond_to do |format|
			format.html {redirect_to(root_path)}
		end
	else
		p=User.new(:email=>a,:password=>b)
		if(p.save)
		session[:user]=p
		respond_to do |format|
			session[:athome]=1
			format.html {redirect_to(users_path)}
		end
		else
			respond_to do |format|
			format.html {redirect_to(root_path,:notice=>"Username already exists!")}
			end
		end	
	end
	end
end
def authenticate
	
	#User.create(:email=>"saransh",:password=>"saransh")
	a=User.find_by_email(params[:email])
	b=User.find_by_password(params[:password])
        respond_to do |format|
	if a && a==b
	session[:user] = a
	session[:athome] = 1
	format.html {redirect_to(users_path)}
	else
		format.html {redirect_to(root_path,:notice=>"Wrong or Non-permitted Details!")}
	end
	end
end
def showall
	@u=session[:user]
		@a=@u.albums.all
		pics="<br/><br/><br/>"
		@a.each do |data|
		dat=data.photos.all
		dat.each do |d|
			pics+='<img src="data:image/gif;base64,'+d.binary_data+'" width="150" height="150" id="'+"#{d.id}"+'" /><button type="button" style="position:relative;bottom:138px;right:27px;font-size:10px;" onclick="del(this.value)" value="'+"#{d.id}"+'" id="'+"#{d.id}"+'">'+"X"+'</button>'
		end	
		end
		send_data(pics,:type => "text/html");
end
def showalb
	@u=session[:user]
		@a=@u.albums.find(params[:data])
		data=@a.photos.all
		pics="<div style='font-size:20px;color:#3F5765;'>"+@a.aname+"</div>"
		data.each do |d|
			pics+='<img class="dr" src="data:image/gif;base64,'+d.binary_data+'" width="100" height="100" id="'+"#{d.id}"+'" draggable="true" ondragstart="drag(event)" />'
		end	
		send_data(pics,:type => "text/html");
end
def remalb
	a=params[:aname1]
	if a
	@u=session[:user]
	@a=@u.albums.find_by_aname(a)
	note="No such album!"
	if @a
	note="Album Removed!"
	x=@a.photos.find_all_by_album_id(@a.id)
	x.each do |y|
		Photo.delete(y.id)
	end
	Album.delete(@a.id)
	end
	end
	respond_to do |format|
	session[:athome]=1
	format.html {redirect_to(users_path,:notice=>note)}
	end
end
def logout
session[:user]=nil
session[:athome]=nil
respond_to do |format|
	format.html {redirect_to(root_path)}
	end
end
def photoframes
	if(session[:user]==nil)
		respond_to do |format|
			format.html {redirect_to(root_path,:notice=>"Please sign in to use the services.")}
		end
	else	
		respond_to do |format|
			session[:athome]=nil
			format.html 
		end
	end
end
def photomugs
	if(session[:user]==nil)
		respond_to do |format|
			format.html {redirect_to(root_path,:notice=>"Please sign in to use the services.")}
		end
	else	
		respond_to do |format|
			session[:athome]=nil
			format.html 
		end
	end
end
def tshirts
	if(session[:user]==nil)
		respond_to do |format|
			format.html {redirect_to(root_path,:notice=>"Please sign in to use the services.")}
		end
	else	
		respond_to do |format|
			session[:athome]=nil
			format.html 
		end
	end
end
def show
	respond_to do |format|
	redirect_to(root_path)
	end
end
end
