using Microsoft.AspNetCore.Mvc;
using MyEyeIsYoursBack.Models;

namespace MyEyeIsYoursBack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationController : ControllerBase
    {
        private readonly AppDbContext appDbContext;
        public NotificationController(AppDbContext appDbContext)
        {
            this.appDbContext = appDbContext;
        }
        // Show all notifications
        [HttpGet("[action]")]
        public async Task<IActionResult> GetAll()
        {
            var notifications = await this.appDbContext.Notifications
                .ToListAsync();
            return Ok(notifications);
        }

        // Show notification by id
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var notification = await appDbContext.Notifications
                .FirstOrDefaultAsync(c => c.Id == id);
            return Ok(notification);

        }

        //Show unaswered notifications
        [HttpGet("[action]")]
        public async Task<IActionResult> GetUnanswred()
        {
            var notifications = await appDbContext.Notifications
                .Where(n => n.IsAnswered == false)
                .ToListAsync();
            List<string> users = new List<string>();
            foreach (var notification in notifications )
            {
                var user = await appDbContext.Users
                    .FirstOrDefaultAsync(u => u.Id == notification.UserId);
                users.Add(user.Name);
                
            }
            return Ok(users);

        }

        //Get answer by id
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> GetNotifByUserId(int id)
        {
            var notification = await appDbContext.Notifications
                .FirstOrDefaultAsync(c => c.UserId == id);
            return Ok(notification);
        }

        // Create a notification
        [HttpPost("[action]")]
        public async Task<IActionResult> Create([FromBody] Notification notification)
        {
            appDbContext.Notifications.Add(notification);
            await appDbContext.SaveChangesAsync();
            return Ok(notification);
        }

        //Update a notification
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> UpdateContent([FromBody] string answer , int id)
        {
            var notification = await appDbContext.Notifications
                .FirstOrDefaultAsync(c => c.Id == id);
            notification.Answer = answer;
            notification.IsAnswered = true;
            await appDbContext.SaveChangesAsync();
            return Ok(notification);
        }


        // Remove a notification 
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Delete(int id)
        {

            var notification = await appDbContext.Notifications
                .FirstOrDefaultAsync(v => v.Id == id);

            appDbContext.Notifications.Remove(notification);
            await appDbContext.SaveChangesAsync();
            return Ok(notification);
        }
    }
}
