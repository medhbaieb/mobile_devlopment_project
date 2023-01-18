namespace MyEyeIsYoursBack.Models
{
    public class Notification
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public int UserId { get; set; }
        public bool IsAnswered { get; set; }
        public string? Answer { get; set; }
    }
}
