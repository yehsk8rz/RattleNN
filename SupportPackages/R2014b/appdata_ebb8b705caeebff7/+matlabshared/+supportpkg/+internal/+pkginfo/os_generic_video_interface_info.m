function supportpkg = os_generic_video_interface_info()
%OS_GENERIC_VIDEO_INTERFACE_INFO Return Image Acquisition Toolbox Support Package for OS Generic Video Interface information.

%   Copyright 2016 The MathWorks, Inc.

supportpkg = hwconnectinstaller.SupportPackage();
supportpkg.Name          = 'OS Generic Video Interface';
supportpkg.Version       = '14.2.1';
supportpkg.Platform      = 'PCWIN,PCWIN64,GLNXA64,MACI64';
supportpkg.Visible       = '1';
supportpkg.FwUpdate      = '';
supportpkg.Url           = 'http://www.mathworks.com';
supportpkg.DownloadUrl   = '';
supportpkg.LicenseUrl    = '';
supportpkg.BaseProduct   = 'Image Acquisition Toolbox';
supportpkg.AllowDownloadWithoutInstall = true;
supportpkg.FullName      = 'Image Acquisition Toolbox Support Package for OS Generic Video Interface';
supportpkg.DisplayName      = 'OS Generic Video Interface';
supportpkg.SupportCategory      = 'hardware';
supportpkg.CustomLicense = '';
supportpkg.CustomLicenseNotes = '';
supportpkg.ShowSPLicense = true;
supportpkg.Folder        = 'genericvideo';
supportpkg.Release       = '(R2014b)';
supportpkg.DownloadDir   = '/Users/lab/Documents/MATLAB/SupportPackages/R2014b/downloads/osgenericvideointerface_download';
supportpkg.InstallDir    = '/Users/lab/Documents/MATLAB/SupportPackages/R2014b';
supportpkg.IsDownloaded  = 0;
supportpkg.IsInstalled   = 1;
supportpkg.RootDir       = '/Users/lab/Documents/MATLAB/SupportPackages/R2014b/osgenericvideointerface/toolbox/imaq/supportpackages/genericvideo';
supportpkg.DemoXml       = '';
supportpkg.ExtraInfoCheckBoxDescription       = '';
supportpkg.ExtraInfoCheckBoxCmd       = '';
supportpkg.FwUpdate      = '';
supportpkg.PreUninstallCmd      = 'matlab:imaqreset;';
supportpkg.InfoUrl      = '';
supportpkg.BaseCode     = 'OSVIDEO';
supportpkg.SupportTypeQualifier      = 'Standard';
supportpkg.CustomMWLicenseFiles      = '';
supportpkg.InstalledDate      = '11-Feb-2016 15:12:18';
supportpkg.InfoText      = 'Acquire+video+and+images+from+generic+video+capture+devices.';
supportpkg.Path{1}      = '/Users/lab/Documents/MATLAB/SupportPackages/R2014b/osgenericvideointerface/toolbox/imaq/supportpackages/genericvideo';

% Third party software information
