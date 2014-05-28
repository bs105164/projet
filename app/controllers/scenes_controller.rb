class ScenesController < ApplicationController
  def edit
     @scene = Scene.find(params[:id])
  end
  
  def new
      @chapitre = Chapitre.find(params[:id])
      @scene = Scene.new
  end
  
  def show
      @scene = Scene.find(params[:id])
  end

  def destroy
    Scene.find(params[:id]).destroy
    flash[:success] = "Scene supprimee."
    redirect_to root_path
  end

  def create
    @chapitre = Chapitre.find(params[:id])
    @scene = @chapitre.scenes.new(params[:scene])
    if @scene.save
      flash[:success] = "Scene creee !"
      redirect_to @scene
    else
      render 'new'
    end
  end

  def update
    @scene = Scene.find(params[:id])
    if @scene.update_attributes(params[:scene])
      flash[:success] = "Scene modifiee !"
      redirect_to @scene
    else
      render 'edit'
    end
  end
end
