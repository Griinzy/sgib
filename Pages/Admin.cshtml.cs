using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Org.BouncyCastle.Asn1.Crmf;
using System.Security.Claims;

namespace pdftest.Pages
{
    [Authorize]
    [IgnoreAntiforgeryToken]
    public class AdminModel : PageModel
    {
        [BindProperty]
        public int UserId { get; set; }

        public void OnPostGetId(int id)
        {
            UserId = id;
        }

        public IActionResult OnGet()
        {
            if(User.FindFirstValue("IsAdmin") == "False") 
            {
                return RedirectToPage("Home");
            }
            return Page();
        }

        public IActionResult OnPostCreateAccount(string firstname, string lastname, string email, string password, string school, string speciality, bool isadmin)
        {
            DbOperations.CreateNewUser(firstname, lastname, email, password, school, speciality, isadmin);
            return RedirectToPage("Admin");
        }

        public void OnPostDeleteUser(int id)
        {
            DbOperations.DeleteUser(id);
        }

        public IActionResult OnGetReturnUser(int id)
        {   
            return new JsonResult(DbOperations.GetUserById(id));
        }

        public IActionResult OnPostEditAccount(string id, string firstname, string lastname, string email, string password, string school, string speciality, bool isadmin)
        {
            DbOperations.UpdateUser(id, firstname, lastname, email, password, school, speciality, isadmin);
            return RedirectToPage("Admin");
        }

        public void OnPostAddCategory(string categoryText, int categoryNum, int ticket, int points)
        {
            int specialityNum = DbOperations.GetSpecialityId(User.FindFirstValue("speciality"));
            
            DbOperations.AddCategory(categoryText, specialityNum, ticket, categoryNum, points);
        }

        public void OnPostAddSpeciality(string speciality)
        {
            DbOperations.AddSpeciality(speciality);
        }
    }
}
