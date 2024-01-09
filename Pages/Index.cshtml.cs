using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using System.Web;

namespace pdftest.Pages
{
    [IgnoreAntiforgeryToken]
    public class IndexModel : PageModel
    {
        public IActionResult OnGet()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToPage("Home");
            }
            return RedirectToPage("Login");
        }
        private readonly ILogger<IndexModel> _logger;

        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }
    }
}