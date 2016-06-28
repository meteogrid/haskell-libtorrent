{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
-- | 

module Libtorrent.ErrorCode where

import           Data.Text (Text)
import           Foreign.ForeignPtr ( ForeignPtr, withForeignPtr )
import qualified Language.C.Inline as C
import qualified Language.C.Inline.Cpp as C
import qualified Language.C.Inline.Unsafe as CU
import System.IO.Unsafe (unsafePerformIO)


import           Libtorrent.Inline
import           Libtorrent.Internal
import           Libtorrent.String
import           Libtorrent.Types


C.context libtorrentCtx

C.include "<system_error>"

C.using "namespace std"

newtype ErrorCode = ErrorCode { unErrorCode :: ForeignPtr (CType ErrorCode)}

instance Show ErrorCode where
  show ec =
    let v = unsafePerformIO $ errorCodeValue ec
        m = unsafePerformIO $ errorCodeMessage ec
    in
     "ErrorCode " ++ show v ++ " " ++ show m

instance Inlinable ErrorCode where
  type (CType ErrorCode) = C'ErrorCode


instance FromPtr ErrorCode where
  fromPtr = objFromPtr ErrorCode $ \ptr ->
    [CU.exp| void { delete $(error_code * ptr) } |]

instance WithPtr ErrorCode where
  withPtr (ErrorCode fptr) = withForeignPtr fptr

newErrorCode :: IO ErrorCode
newErrorCode =
  fromPtr [CU.exp| error_code * { new error_code() } |]

errorCodeValue :: ErrorCode -> IO C.CInt
errorCodeValue (ErrorCode fptr) =
  withForeignPtr fptr $ \ptr ->
  [CU.exp| int { $(error_code * ptr)->value() } |]

errorCodeMessage :: ErrorCode -> IO Text
errorCodeMessage (ErrorCode fptr) =
  withForeignPtr fptr $ \ptr -> do
    msg <- fromPtr [CU.exp| string * { new string($(error_code * ptr)->message()) } |]
    stdStringToText msg

