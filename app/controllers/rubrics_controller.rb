class RubricsController < ApplicationController
  #  GET /courses/:course_id/assignments/:assignment_id/rubrics
  def index; end

  #  POST /courses/:course_id/assignments/:assignment_id/rubrics
  def create
    @rubric = Rubric.new(assignment_id: @assignment.id)
    @rubric.update!(rubric_params)

    flash.notice = "Rubric for #{@rubric.type} created."
    redirect_back fallback_location: { action: :index }
  end

  #  PUT /courses/:course_id/assignments/:assignment_id/rubrics/:id (save one)
  #  PUT /courses/:course_id/assignments/:assignment_id/rubrics     (save all)
  def update
    id = params[:id]

    if id
      rubric = Rubric.find(id)
      rubric.update(rubric_params.except(:criteria))
      rubric.update_criteria(rubric_params[:criteria])
      flash.notice = "Rubric '#{rubric}' updated."
    else
      flash.alert = 'Not implemented.'
    end

    redirect_back fallback_location: { action: :index }
  end

  def destroy
    rubric = Rubric.find(params[:id])
    name = rubric.to_s
    rubric.destroy!

    flash.notice = "Rubric '#{name}' deleted."
    redirect_back fallback_location: { action: :index }
  end

  def show
    # code here
  end

  private

  def rubric_params
    params.require(:rubric).permit!
  end
end
