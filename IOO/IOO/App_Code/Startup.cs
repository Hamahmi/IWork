using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(IOO.Startup))]
namespace IOO
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
