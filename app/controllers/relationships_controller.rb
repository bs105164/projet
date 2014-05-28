class RelationshipsController < ApplicationController

  def create
    @personne = Personne.find(params[:relationship][:personne_id])
    @scene = Scene.find(params[:relationship][:scene_id])
    @scene.appartient!(@personne)
    respond_to do |format|
      format.html { redirect_to @scene }
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @personne = Personne.find( @relationship.personne_id)
    @scene = Scene.find(@relationship.scene_id)
    @scene.desappartient!(@personne)
    respond_to do |format|
      format.html { redirect_to @scene }
      format.js
    end
  end
end

