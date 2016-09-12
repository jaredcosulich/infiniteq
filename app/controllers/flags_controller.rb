class FlagsController < ApplicationController
  before_action :set_flag, only: [:show, :edit, :update, :destroy]

  # GET /flags
  # GET /flags.json
  def index
    @flags = Flag.all
  end

  # GET /flags/1
  # GET /flags/1.json
  def show
    @grouped_flag = @flag.group
  end

  # GET /flags/new
  def new
    @flag = Flag.new
  end

  # GET /flags/1/edit
  def edit
  end

  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(flag_params.merge(user: current_user))

    respond_to do |format|
      if @flag.save
        format.html do
          unless user_signed_in?
            @temporary_user = TemporaryUser.add_object(@flag, request.remote_ip)
          end

          if @flag.suspect || @flag.dispute?
            head :ok
          else
            render @flag.object.reload
          end
        end
        format.json { render @flag.object.reload, status: :created, location: @flag }
      else
        format.html { render partial: 'flags/errors', locals: {flag: @flag}, status: 400 }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flags/1
  # PATCH/PUT /flags/1.json
  def update
    respond_to do |format|
      if @flag.update(flag_params)
        format.html { redirect_to @flag, notice: 'Flag was successfully updated.' }
        format.json { render :show, status: :ok, location: @flag }
        AdminMailer.object_created(@flag).deliver_now
      else
        format.html { render :edit }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    unless user_signed_in?
      @temporary_user.remove_object(@flag)
    end

    object = @flag.object
    @flag.destroy
    respond_to do |format|
      format.html { redirect_to object.try(:question) || object, notice: 'Flag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flag
      @flag = Flag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flag_params
      params.require(:flag).permit(:reason, :question_id, :answer_id, :trust, :details, :action, :dispute)
    end
end
