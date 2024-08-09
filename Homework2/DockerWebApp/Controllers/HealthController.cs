using Microsoft.AspNetCore.Mvc;

namespace DockerWebApp.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HealthController : ControllerBase
    {      
        private readonly ILogger<HealthController> _logger;

        public HealthController(ILogger<HealthController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public Response.Response Health()
        {
            return new Response.Response
            {
                Status = "OK"
            };
        }
    }
}
