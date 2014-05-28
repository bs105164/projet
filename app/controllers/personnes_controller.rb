class PersonnesController < ApplicationController
 def new
     @personne = Personne.new
  end

  def show
      @personne = Personne.find(params[:id])
      @scenes = @personne.reverse_relationships.find(:all, @personne.id)
  end

  def index
     @personnes = Personne.paginate(page: params[:page])
  end

  def create
    @personne = Personne.new(params[:personne])
    if @personne.save
        flash[:success] = "Personne ajoute"
	redirect_to @personne
    else
	render 'new'
    end
  end

  def edit
     @personne = Personne.find(params[:id])
  end

  def destroy
    
    Personne.find(params[:id]).destroy
    flash[:success] = "Personne supprime."
    redirect_to root_path
  end

  def update
    @personne = Personne.find(params[:id])
    if @personne.update_attributes(params[:personne])
      flash[:success] = "Personne modifie !"
      redirect_to @personne
    else
      render 'edit'
    end
  end
end
