using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MySql.Data.MySqlClient;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;

namespace pdftest.Pages
{
    [IgnoreAntiforgeryToken]
    public class LoginModel : PageModel
    {
        private static string connectionString = DbOperations.connection;
        private static string conString2 = "Data source=DESKTOP-GQNFF8F; Database=PdfTests; User=User1; Pwd=admin;";

        [BindProperty]
        public string IncorrectPassword { get; set; }

        public IActionResult OnGet()
        {
            if(User.Identity.IsAuthenticated)
            {
                return RedirectToPage("Home");
            }
            return Page();
        }

        public async Task<IActionResult> OnPostLogin(string emailText, string passwordText, bool remember) 
        {
            User user = LoginCheck(emailText, passwordText);
            if(user != null)
            {
                await SignInUser(user, remember);
                return RedirectToPage("Home");
            }
            IncorrectPassword = "Неправилна парола";
            return Page();
        }

        public static User LoginCheck(string emailText, string passwordText)
        {
            MySqlConnection con = new MySqlConnection(connectionString);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand("Select a.id, a.firstName, a.lastName, a.email, a.password , sp.specialityName, a.isadmin, s.schoolName from accounts as a inner join schools as s on a.school = s.id inner join specialities as sp on a.speciality = sp.id where email = @email;", con);
                cmd.Parameters.AddWithValue("email", emailText);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        string encodedPassword = rdr.GetString("password");
                        byte[] encodedPassBytes = System.Convert.FromBase64String(encodedPassword);
                        string password = System.Text.Encoding.UTF8.GetString(encodedPassBytes);
                        if (passwordText == password)
                        {
                            User user = new User();
                            user.FirstName = rdr.GetString("firstName");
                            user.LastName = rdr.GetString("lastName");
                            user.Email = emailText;
                            user.Speciality = rdr.GetString("specialityName");
                            user.School = rdr.GetString("schoolName");
                            user.IsAdmin = rdr.GetString("IsAdmin");
                            con.Close();
                            return user;
                        }
                    }
                }
            }
            con.Close();
            return null;
        }

        public async Task SignInUser(User user, bool remember)
        {
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, user.FirstName),
                new Claim(ClaimTypes.Surname, user.LastName),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim("Speciality", user.Speciality),
                new Claim("School", user.School),
                new Claim("isAdmin", user.IsAdmin)
            };

            ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            await HttpContext.SignInAsync(
                CookieAuthenticationDefaults.AuthenticationScheme, 
                new ClaimsPrincipal(claimsIdentity), 
                new AuthenticationProperties { IsPersistent = remember });
        }

    }
}
