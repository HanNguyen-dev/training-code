using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using PizzaBox.Client.Models;

namespace PizzaBox.Client.Controllers
{
    [Route("/[controller]/[action]")]
    // [Route("/[controller]")]
    public class HomeController : Controller // home instead of HomeController is the same thing.
    {

        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }
        // [Route("/boo")]
        // [HttpGet()]
        [HttpGet("{id}")]  // this is parameter, this is a restriction.
        public IActionResult Index(string id)
        {
            ViewBag.Name = id;
            ViewData["Name"] = id;
            TempData["Name"] = id;
            ViewBag.Pizza = new Pizza();
            return View(new Pizza());
        }

        [HttpPost()]
        public IActionResult Order(Pizza p)
        {
          ViewBag.Pizza = p;
          // return View("index", p);
          return View("Index", new Pizza());
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
