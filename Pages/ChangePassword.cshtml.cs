using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MySql.Data.MySqlClient;
using System.Security.Claims;

namespace pdftest.Pages
{
    [Authorize]
    [IgnoreAntiforgeryToken]
    public class ChangePassword : PageModel
    {
        [BindProperty]
        public string ErrorMessage { get; set; }

        public IActionResult OnPostChangePassword(string oldPassword, string newPassword, string confirmNewPassword)
        {
            if (newPassword != string.Empty && newPassword == confirmNewPassword)
            {
                if (oldPassword == DbOperations.GetPasswordByEmail(User.FindFirstValue(ClaimTypes.Email)))
                {
                    DbOperations.UpdatePassword(User.FindFirstValue(ClaimTypes.Email), newPassword);
                    return RedirectToPage("Home");
                }
                else
                {
                    ErrorMessage = "Неправилна парола.";
                }
            }
            else
            {
                ErrorMessage = "Паролите не съвпадат.";
            }
            return Page();
        }
    }
}
