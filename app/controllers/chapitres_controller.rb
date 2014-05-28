class ChapitresController < ApplicationController
  def new
     @chapitre = Chapitre.new
  end

  def show
      @chapitre = Chapitre.find(params[:id])
      @scenes = @chapitre.scenes.paginate(page: params[:page])
      @anecdotes = @chapitre.anecdotes.paginate(page: params[:page])
  end

  def index
     @chapitres = Chapitre.paginate(page: params[:page])
  end

  def create
    @chapitre = Chapitre.new(params[:chapitre])
    if @chapitre.save
        flash[:success] = "Chapitre ajoute"
	redirect_to @chapitre
    else
	render 'new'
    end
  end

  def edit
     @chapitre = Chapitre.find(params[:id])
  end

  def destroy
    Chapitre.find(params[:id]).destroy
    flash[:success] = "Chapitre supprime."
    redirect_to chapters_path
  end

  def update
    @chapitre = Chapitre.find(params[:id])
    if @chapitre.update_attributes(params[:chapitre])
      flash[:success] = "Chapitre modifie !"
      redirect_to @chapitre
    else
      render 'edit'
    end
  end
end
