require 'spec_helper'

describe ProjectsController do
  it "should display error for missing project" do
    get :show, id: "non-existent"
    expect(response).to redirect_to projects_path
    expect(flash[:alert]).to eq "The project you were looking for could not be found"
  end
end
