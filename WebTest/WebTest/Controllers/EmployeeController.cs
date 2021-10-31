using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using WebTest.Interfaces;
using WebTest.Models;

namespace WebTest.Controllers
{
    public class EmployeeController : Controller
    {
        private IEmployeeService employeeService;
        private ICompanyService companyService;

        public EmployeeController(IEmployeeService employeeService, ICompanyService companyService)
        {
            this.employeeService = employeeService;
            this.companyService = companyService;
        }

        public ActionResult Index()
        {
            var list = employeeService.GetList();
            return View(list);
        }

        public ActionResult Create()
        {
            var companies = companyService.GetList();
            ViewBag.Companies = new SelectList(companies, "Id", "Name");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Employee employee)
        {
            try
            {
                employeeService.Insert(employee);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Index));
            }
        }

        public ActionResult Edit(int id)
        {
            Employee employee = employeeService.GetById(id);
            var companies = companyService.GetList();
            ViewBag.Companies = new SelectList(companies, "Id", "Name");
            return View(employee);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Employee employee)
        {
            try
            {
                employeeService.Edit(employee);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            try
            {
                employeeService.Delete(id);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Index));
            }
        }
    }
}
