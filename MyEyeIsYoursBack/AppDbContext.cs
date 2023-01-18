using Microsoft.EntityFrameworkCore;
using MyEyeIsYoursBack.Models;

namespace MyEyeIsYoursBack
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
        {
        }
        public DbSet<User> Users { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Notification>()
                .HasOne<User>()
                .WithMany(n => n.Notifications)
                .HasForeignKey(n => n.UserId)
                .OnDelete(DeleteBehavior.NoAction);
        }
        
    }

}
