module TicketsHelper
  def state_for(comment)
    if comment.state
      previous_state = comment.previous_state
      if previous_state  && comment.state != previous_state
        ("#{render previous_state} &rarr; #{render comment.state}").html_safe
      else
        render comment.state
      end
    end
  end
end
