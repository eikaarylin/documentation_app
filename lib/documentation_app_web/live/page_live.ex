defmodule DocumentationAppWeb.PageLive do
  use DocumentationAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    case assigns.live_action do
      :home ->
        ~H"""
        <h1>Welcome to Documentation App</h1>
        <p>Please login or register to continue.</p>
        """

      :admin ->
        if assigns.current_user && assigns.current_user.role == "admin" do
          ~H"<h1>You are in the admin page</h1>"
        else
          ~H"<h1>Access denied</h1>"
        end

      :user ->
        if assigns.current_user && assigns.current_user.role == "user" do
          ~H"<h1>You are in the user page</h1>"
        else
          ~H"<h1>Access denied</h1>"
        end
    end
  end
end
