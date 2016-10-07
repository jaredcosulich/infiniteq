class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :questions]
  before_action :set_topic, only: [:show, :questions, :edit, :update, :destroy]
  skip_after_action :set_return_to, only: [:create, :update, :destroy, :questions]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @questions = (params[:f] == 't' ? @topic.questions : @topic.all_questions)
    @question = @topic.questions.new
  end

  def questions
    respond_to do |format|
      format.json do
        render json: @topic.all_questions.as_json(
          only: [:id, :text, :slug],
          include: { topic: { only: [], methods: [:path] } }
        )
      end
      format.html do
        head :ok
      end
    end
  end

  # GET /topics/new
  def new
    if params.include?(:parent_topic_id)
      @parent_topic = Topic.friendly.find(params[:parent_topic_id])
    end
    @topic = Topic.new(parent_topic_id: @parent_topic.try(:id))
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params.merge(user: current_user))
    @topic.followings.build(user: current_user) if user_signed_in?

    respond_to do |format|
      if @topic.save
        AdminMailer.delay.object_created(@topic)
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.friendly.find(params[:id] || params[:topic_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :description, :parent_topic_id)
    end
end
