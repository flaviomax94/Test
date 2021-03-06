class RatingsController < ApplicationController
skip_before_action :verify_authenticity_token
def new
    @rating=Rating.new
end

def create
   @rating = Rating.new(rating_params)
   respond_to do |format|
	if @rating.save
	flash[:success] = "Voto inserito"
     format.html { redirect_to (:back)}
    format.json { render :show, status: :ok, location: @officina}
	else
	flash[:danger]= "Errore aggiunta voto"
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
     
    end
  end

def update
  @rating = Rating.find(params[:id])
    respond_to do |format|
      
      if @rating.update(rating_params)
	flash[:success] = "Voto aggiornato correttamente."
        format.html { redirect_to (:back)}
        format.json { render :show, status: :ok, location: @rating}
      else
	flash[:danger] = "Errore nella modifica del voto."
        format.html { render :show }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      
      end
end
end
private 
  def rating_params
      params.require(:ratings).permit(:user_id, :officina_id,:voto)
  end
end
