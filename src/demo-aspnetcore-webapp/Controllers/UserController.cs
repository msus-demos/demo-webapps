using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Security.Principal;
using System.Security.Claims;

namespace aad_b2c_dotnet.Controllers
{
    public class UserController : Controller
    {
        [Authorize]
        public IActionResult Index()
        {
            ViewData["email"] = User.Claims.FirstOrDefault(a=> a.Type == ClaimTypes.Email);
            return View();
        }
    }
}
