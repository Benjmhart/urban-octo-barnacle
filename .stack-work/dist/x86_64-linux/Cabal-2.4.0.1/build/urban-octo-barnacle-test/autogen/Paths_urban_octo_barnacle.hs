{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_urban_octo_barnacle (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ben/Projects/urban-octo-barnacle/.stack-work/install/x86_64-linux/2e1d42408a65991f53ea066c66018e2ca002f07a2e119c317ff9e239a018629f/8.6.3/bin"
libdir     = "/home/ben/Projects/urban-octo-barnacle/.stack-work/install/x86_64-linux/2e1d42408a65991f53ea066c66018e2ca002f07a2e119c317ff9e239a018629f/8.6.3/lib/x86_64-linux-ghc-8.6.3/urban-octo-barnacle-0.0.0-5EudXtyl44o54KZJsHPYhN-urban-octo-barnacle-test"
dynlibdir  = "/home/ben/Projects/urban-octo-barnacle/.stack-work/install/x86_64-linux/2e1d42408a65991f53ea066c66018e2ca002f07a2e119c317ff9e239a018629f/8.6.3/lib/x86_64-linux-ghc-8.6.3"
datadir    = "/home/ben/Projects/urban-octo-barnacle/.stack-work/install/x86_64-linux/2e1d42408a65991f53ea066c66018e2ca002f07a2e119c317ff9e239a018629f/8.6.3/share/x86_64-linux-ghc-8.6.3/urban-octo-barnacle-0.0.0"
libexecdir = "/home/ben/Projects/urban-octo-barnacle/.stack-work/install/x86_64-linux/2e1d42408a65991f53ea066c66018e2ca002f07a2e119c317ff9e239a018629f/8.6.3/libexec/x86_64-linux-ghc-8.6.3/urban-octo-barnacle-0.0.0"
sysconfdir = "/home/ben/Projects/urban-octo-barnacle/.stack-work/install/x86_64-linux/2e1d42408a65991f53ea066c66018e2ca002f07a2e119c317ff9e239a018629f/8.6.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "urban_octo_barnacle_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "urban_octo_barnacle_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "urban_octo_barnacle_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "urban_octo_barnacle_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "urban_octo_barnacle_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "urban_octo_barnacle_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
