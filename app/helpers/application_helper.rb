module ApplicationHelper

  def check_controller_and_action(controller, action)
    controller_name == controller and action_name == action
  end

  def render_glyphicon(g_name)
    content_tag(:i, '', class: ["glyphicon", "glyphicon-#{g_name}"])
  end
end
