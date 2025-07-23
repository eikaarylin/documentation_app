alias DocumentationApp.Repo
alias DocumentationApp.Accounts.User

unless Repo.get_by(User, email: "admin@gmail.com") do
  params = %{
    email: "admin@gmail.com",
    password: "eikaarylin1234"
  }

  %User{}
  |> User.registration_changeset(params)
  |> Ecto.Changeset.change(%{
      role: "admin",
      confirmed_at: DateTime.utc_now() |> DateTime.truncate(:second)
    })
  |> Repo.insert!()

  IO.puts("✅ Admin user created!")
end
