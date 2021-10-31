using Microsoft.AspNetCore.Mvc;
using WebTest.Interfaces;
using WebTest.Models;

namespace WebTest.Controllers
{
    public class CompanyController : Controller
    {
        private ICompanyService companyService;

        public CompanyController(ICompanyService companyService)
        {
            this.companyService = companyService;
        }

        public ActionResult Index()
        {
            var list = companyService.GetList();
            return View(list);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Company company)
        {
            try
            {
                companyService.Insert(company);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Index));
            }
        }

        public ActionResult Edit(int id)
        {
            Company company = companyService.GetById(id);
            return View(company);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Company company)
        {
            try
            {
                companyService.Edit(company);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Index));
            }
        }

        public ActionResult Delete(int id)
        {
            try
            {
                companyService.Delete(id);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Index));
            }
        }
    }
}
