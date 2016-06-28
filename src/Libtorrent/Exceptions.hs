-- | "Libtorrent" exceptions
module Libtorrent.Exceptions (LibtorrentException(..)
                             , withErrorCode
                             , withLibtorrentException
                             , exceptU
                             , except
                             ) where

import Control.Monad (when)
import Control.Monad.Catch
import Foreign.Ptr ( Ptr, nullPtr )

import Libtorrent.ErrorCode
import Libtorrent.Exceptions.Internal
import Libtorrent.Types
import Libtorrent.Inline


data LibtorrentException =
  TorrentInfoError !ErrorCode
  | AddTorrentError !ErrorCode
  | TorrentHandleError !ErrorCode
  | BDecodeError !ErrorCode
  deriving Show

instance Exception LibtorrentException

-- | 'libtorrent' usually use 'error_code' to indicate error
withErrorCode :: (ErrorCode -> LibtorrentException)
                 -> (Ptr C'ErrorCode -> IO a)
                 -> IO a
withErrorCode toErr action = do
  ec <- newErrorCode
  res <- withPtr ec action
  ev <- errorCodeValue ec
  case ev of
    0 ->
      return res
    _ ->
      throwM $ toErr ec

withLibtorrentException :: (ErrorCode -> LibtorrentException)
                        -> IO (Ptr C'ErrorCode)
                        -> IO ()
withLibtorrentException toErr action = mask_ $ do
  exceptPtr <- action
  when (exceptPtr /= nullPtr) $
    fromPtr (pure exceptPtr) >>= throwM . toErr
