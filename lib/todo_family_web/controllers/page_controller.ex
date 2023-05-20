defmodule TodoFamilyWeb.PageController do
  use TodoFamilyWeb, :controller

  def home(conn, _params) do
    render(conn, :home, active_tab: :home)
  end
end
