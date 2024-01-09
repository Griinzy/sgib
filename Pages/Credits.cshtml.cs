using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Security.Claims;

namespace pdftest.Pages
{
    [Authorize]
    [IgnoreAntiforgeryToken]
    public class CreditsModel : PageModel
    {
        public void OnGet()
        {

        }
    }
}