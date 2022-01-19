class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :status_color, :priority_color, :date_color


  def after_sign_in_path_for(resource)
    stored_location_for(resource) || projects_path
  end

  def status_color(item)
    if item.status == 100
      return "green"
    else
      return "gray"
    end
  end

  def priority_color(item)
    if item.priority == "Negligible"
      return "green"
    elsif item.priority == "Moderate"
      return "orange"
    elsif item.priority == "Critical"
      return "red"
    end
  end

  def date_color(item)
    return "gray" if item.start_date > Time.now

    return "green" if item.start_date >= Time.now && item.due_date < Time.now

    return "orange" if item.start_date >= Time.now && item.due_date == Time.now

    return "red" if item.start_date > Time.now && item.due_date > Time.now
  end

end
