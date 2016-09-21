# Task5

**Q:** What is difference between windows_package installer types?

**A:** They use different 'engines' to go through the installation process.

**Q:** Can you use :custom installer_type for any package?

**A:** Per chef documentation, there are no direct limitations, but this
only makes sense for cases of installer being embedded into some other
type of file. At least it works instead of :msi (I tested this).

**Q:** Which one you used and why?

**A:** :msi and :custom, first for a package supplied as .msi, and
second just to test how it works. For all packages shipped as .exe
files, allowed chef to pick the installer type automatically.

**Q:** What is difference between windows_package providers?

**A:** Unlike multiplatform 'package' resource, 'windows_package' has
only 2 options for a provider: 'Chef::Provider::Package::Windows' that
forces a provider for Windows platform, and 'Chef::Provider::Package'
that should select most suitable option between available providers
automatically, in our case falling to 'Chef::Provider::Package::Windows'
due to no other option. Thus, there is no difference currently, except
few more milliseconds spent to make a decision.

**Q:** Which one you used and why?

**A:** Did not force, so 'Chef::Provider::Package::Windows' was used
as default one.

**Q:** What is difference between windows_feature providers?

**A:** An 'engine' used to manage roles and features (DISM /
Server Manager / PowerShell).

**Q:** Which one you used and why?

**A:** Chef::Provider::WindowsFeature::ServerManagerCmd as default one.

**Q:** What is DISM?

**A:** Deployment Image Servicing and Management, CLI tool for
managing packages, drivers, features for Windows, preparing images
etc.

**Q:** Explain disadvantages of DISM

**A:** Works with local packages only, is limited with .cab, .msu and .inf
packages (does not support .msi and 3rdparty installers), installing
dependencies could be complex.
