using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Security.Claims;

namespace pdftest.Pages
{
    [Authorize]
    public class QuestionsModel : PageModel
    {
        public void OnGet()
        {
            
        }
    }
}
