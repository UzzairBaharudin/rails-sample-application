class ImportantPointsController < ApplicationController
  before_action :set_important_point, only: [:show, :edit, :update, :destroy]

  def index
    @important_points = ImportantPoint.all.order('created_at ASC')
    respond_to  do |format|
      format.html
      format.pdf do
        render pdf: 'index',
               layout: 'pdf.html.erb',
               template: 'important_points/index.pdf.slim',
               header: { :right => '[page] of [topage]'},
               margin: {top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0},
               outline: {outline: true,
                         outline_depth: 2}
        # 'important_points/index.pdf.slim'
      end
    end
  end

  def show

  end

  def new
    @important_point = ImportantPoint.new

  end

  def edit
  end

  def create
    @important_point = ImportantPoint.new(important_point_params)
    @important_point.save
    redirect_to important_points_path

  end

  def update
    @important_point.update(important_point_params)

  end

  def destroy
    @important_point.destroy

  end

  private
    def set_important_point
      @important_point = ImportantPoint.find(params[:id])
    end

    def important_point_params
      params.require(:important_point).permit(:title, :description)
    end
end
