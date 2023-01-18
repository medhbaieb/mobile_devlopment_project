using Microsoft.AspNetCore.Mvc;
using MyEyeIsYoursBack.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace MyEyeIsYoursBack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext appDbContext;
        public UserController(AppDbContext appDbContext)
        {
            this.appDbContext = appDbContext;
        }
        // Show all users
        [HttpGet("[action]")]
        public async Task<IActionResult> GetAll()
        {
            var users =  await this.appDbContext.Users
                .ToListAsync();
            return Ok(users);
        }

        // Show user by id
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var user = await appDbContext.Users
                .Include(c => c.Notifications)
                .FirstOrDefaultAsync(c => c.Id == id);
            return Ok(user);

        }

       

        // Create a user
        [HttpPost("[action]")]
        public async Task<IActionResult> Create([FromBody] User user)
        {
            appDbContext.Users.Add(user);
            await appDbContext.SaveChangesAsync();
            return Ok(user);
        }


        // Remove user 
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var notifications = await appDbContext.Notifications
                .Where(r => r.UserId == id)
                .ToListAsync();
            foreach (var n in notifications)
            {
                appDbContext.Notifications.Remove(n);
            }
            
            var user = await appDbContext.Users
                .FirstOrDefaultAsync(v => v.Id == id);

            appDbContext.Users.Remove(user);
            await appDbContext.SaveChangesAsync();
            return Ok(user);
        }

        // SignIn
        [HttpGet("[action]/{mail}")]
        public async Task<bool> VerifyUser(string mail, string mdp)
        {
            
            User VerifUser = null;
            foreach (var user in appDbContext.Users)
            {
                if (user.Email == mail)
                {
                    
                    VerifUser = user;
                }
            }
            if (VerifUser == null)
            {
                return false;
            }
            else
            {
                if (mdp == VerifUser.Password )
                {
                    return true;
                }
            }
            return false;
        }

        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> getUserFromNotif(int id)
        {
            var notification = await appDbContext.Notifications
                    .FirstOrDefaultAsync(c => c.Id == id);
            var NewId = notification.UserId;
            foreach (var user in appDbContext.Users)
            {
                if (user.Id == NewId)
                {
                    return Ok(user.Name);
                }
            }
            return BadRequest();
        }
    }
    
}
