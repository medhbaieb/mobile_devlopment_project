namespace MyEyeIsYoursBack.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Photo { get; set; }
        public bool IsBlind { get; set; }
        public virtual ICollection<Notification>? Notifications { get; set; }
    }
}
