using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using aad_b2c_dotnet.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.AzureADB2C.UI;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Clients.ActiveDirectory;

namespace aad_b2c_dotnet
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });

            services.AddDbContext<BloggingContext>(options => {
                AzureServiceTokenProvider provider = new AzureServiceTokenProvider();
                var token = provider.GetAccessTokenAsync ("https://database.windows.net/").GetAwaiter().GetResult();

                SqlConnection connection = new SqlConnection();
                connection.ConnectionString = Configuration.GetConnectionString("Database");
                connection.AccessToken = token;
        
                options.UseSqlServer(connection);
            });
            
            // services.AddAuthentication(AzureADB2CDefaults.AuthenticationScheme)
            //     .AddAzureADB2C(options => Configuration.Bind("AzureAdB2C", options));

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
        }

        // Use for SP login (Non MSI)
        public static string GetAccessToken(string tenantId, string clientId, string clientSecret)
        {
            var authContextUrl = "https://login.windows.net/" + tenantId;
            var authenticationContext = new AuthenticationContext(authContextUrl);
            var credential = new ClientCredential(clientId, clientSecret);
            var result = authenticationContext.AcquireTokenAsync(resource: "https://database.windows.net/", clientCredential: credential).Result;
            
            if (result == null)
            {
            throw new InvalidOperationException("Failed to obtain the JWT token");
            }
            
            var token = result.AccessToken;
            return token;
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            app.UseDeveloperExceptionPage();

            app.UseStaticFiles();
            app.UseCookiePolicy();

            app.UseAuthentication();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
