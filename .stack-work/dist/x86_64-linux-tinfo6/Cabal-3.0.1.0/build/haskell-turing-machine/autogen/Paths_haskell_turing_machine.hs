{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_haskell_turing_machine (
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
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/henrique/Documents/Projects/Public/haskell-turing-machine/.stack-work/install/x86_64-linux-tinfo6/877853bf8d9995777515a0b978faadffa6fa62337b565b84560dd79dbe4a74d6/8.8.3/bin"
libdir     = "/home/henrique/Documents/Projects/Public/haskell-turing-machine/.stack-work/install/x86_64-linux-tinfo6/877853bf8d9995777515a0b978faadffa6fa62337b565b84560dd79dbe4a74d6/8.8.3/lib/x86_64-linux-ghc-8.8.3/haskell-turing-machine-0.1.0.0-B7xxcR2HY8JDbAToRnbhI-haskell-turing-machine"
dynlibdir  = "/home/henrique/Documents/Projects/Public/haskell-turing-machine/.stack-work/install/x86_64-linux-tinfo6/877853bf8d9995777515a0b978faadffa6fa62337b565b84560dd79dbe4a74d6/8.8.3/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/henrique/Documents/Projects/Public/haskell-turing-machine/.stack-work/install/x86_64-linux-tinfo6/877853bf8d9995777515a0b978faadffa6fa62337b565b84560dd79dbe4a74d6/8.8.3/share/x86_64-linux-ghc-8.8.3/haskell-turing-machine-0.1.0.0"
libexecdir = "/home/henrique/Documents/Projects/Public/haskell-turing-machine/.stack-work/install/x86_64-linux-tinfo6/877853bf8d9995777515a0b978faadffa6fa62337b565b84560dd79dbe4a74d6/8.8.3/libexec/x86_64-linux-ghc-8.8.3/haskell-turing-machine-0.1.0.0"
sysconfdir = "/home/henrique/Documents/Projects/Public/haskell-turing-machine/.stack-work/install/x86_64-linux-tinfo6/877853bf8d9995777515a0b978faadffa6fa62337b565b84560dd79dbe4a74d6/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "haskell_turing_machine_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "haskell_turing_machine_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "haskell_turing_machine_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "haskell_turing_machine_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_turing_machine_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_turing_machine_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
