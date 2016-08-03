{-# LANGUAGE QuasiQuotes     #-}
{-# LANGUAGE TemplateHaskell #-}
{- | <http://www.libtorrent.org libtorrent> bindings for Haskell.
Structure of this document follows original <http://www.libtorrent.org/reference.html documentation>
so you can use it for referencing.
-}
module Network.Libtorrent (
  -- * Core
  version
  -- ** PeerInfo
  ,PeerFlags(..)
  , PeerSourceFlags(..)
  , ConnectionType(..)
  , BwState(..)
  , PeerInfo(..)
  , getClient
  , setClient
  , getPeerInfoPieces
  , setPeerInfoPieces
  , getPeerInfoTotalDownload
  , setPeerInfoTotalDownload
  , getPeerInfoTotalUpload
  , setPeerInfoTotalUpload
  , getLastRequest
  , setLastRequest
  , getLastActive
  , setLastActive
  , getDownloadQueueTime
  , setDownloadQueueTime
  , getPeerInfoFlags
  , setPeerInfoFlags
  , getPeerInfoSource
  , setPeerInfoSource
  , getUpSpeed
  , setUpSpeed
  , getDownSpeed
  , setDownSpeed
  , getPayloadUpSpeed
  , setPayloadUpSpeed
  , getPayloadDownSpeed
  , setPayloadDownSpeed
  , getPid
  , setPid
  , getQueueBytes
  , setQueueBytes
  , getPeerInfoRequestTimeout
  , setPeerInfoRequestTimeout
  , getSendBufferSize
  , setSendBufferSize
  , getUsedSendBuffer
  , setUsedSendBuffer
  , getReceiveBufferSize
  , setReceiveBufferSize
  , getUsedReceiveBuffer
  , setUsedReceiveBuffer
  , getNumHashfails
  , setNumHashfails
  , getDownloadQueueLength
  , setDownloadQueueLength
  , getTimedOutRequests
  , setTimedOutRequests
  , getBusyRequests
  , setBusyRequests
  , getRequestsInBuffer
  , setRequestsInBuffer
  , getTargetDlQueueLength
  , setTargetDlQueueLength
  , getUploadQueueLength
  , setUploadQueueLength
  , getFailcount
  , setFailcount
  , getDownloadingPieceIndex
  , setDownloadingPieceIndex
  , getDownloadingBlockIndex
  , setDownloadingBlockIndex
  , getDownloadingProgress
  , setDownloadingProgress
  , getDownloadingTotal
  , setDownloadingTotal
  , getConnectionType
  , setConnectionType
  , getRemoteDlRate
  , setRemoteDlRate
  , getPendingDiskBytes
  , setPendingDiskBytes
  , getSendQuota
  , setSendQuota
  , getReceiveQuota
  , setReceiveQuota
  , getRtt
  , setRtt
  , getPeerInfoNumPieces
  , setPeerInfoNumPieces
  , getDownloadRatePeak
  , setDownloadRatePeak
  , getUploadRatePeak
  , setUploadRatePeak
  , getPeerInfoProgressPpm
  , setPeerInfoProgressPpm
  , getEstimatedReciprocationRate
  , setEstimatedReciprocationRate
  , getIp
  , getLocalEndpoint
  , getReadState
  , setReadState
  , getWriteState
  , setWriteState
  -- ** PeerRequest
  , PeerRequest
  , unPeerRequest
  , getPiece
  , getStart
  , getLength
  -- ** BlockInfo
  , BlockState(..)
  , BlockInfo(..)
  , getBytesProgress
  , getBlockInfoBlockSize
  , getBlockInfoNumPeers
  , getBlockInfoState
  -- ** PartialPieceInfo
  , PieceState(..)
  , PartialPieceInfo(..)
  , getPieceIndex
  , getBlocksInPiece
  , getFinished
  , getWriting
  , getRequested
  , getBlocks
  , getPieceState
  -- ** TorrentHandle
  , TorrentHandle(..)
  , StatusFlags(..)
  , DeadlineFlags(..)
  , FileProgressFlags(..)
  , PauseFlags(..)
  , SaveResumeFlags(..)
  , newTorrentHandle
  , addPiece
  , readPiece
  , havePiece
  , getPeerInfo
  , torrentStatus
  , getDownloadQueue
  , resetPieceDeadline
  , clearPieceDeadlines
  , setPieceDeadline
  , setPriority
  , fileProgress
  , clearError
  , trackers
  , replaceTrackers
  , addTracker
  , addUrlSeed
  , removeUrlSeed
  , addHttpSeed
  , removeHttpSeed
  , setMetadata
  , isValid
  , pause
  , resume
  , setUploadMode
  , setShareMode
  , flushCache
  , applyIpFilter
  , forceRecheck
  , saveResumeData
  , needSaveResumeData
  , autoManaged
  , queuePositionDown
  , queuePositionTop
  , queuePosition
  , queuePositionBottom
  , queuePositionUp
  , setSslCertificate
  , useInterface
  , pieceAvailability
  , piecePriority
  , piecePriorities
  , setPiecePriority
  , prioritizePieces
  , filePriority
  , filePriorities
  , setFilePriority
  , prioritizeFiles
  , forceReannounce
  , forceDhtAnnounce
  , scrapeTracker
  , torrentHandleUploadLimit
  , torrentHandleDownloadLimit
  , setTorrentHandleUploadLimit
  , setTorrentHandleDownloadLimit
  , setSequentialDownload
  , torrentHandleMaxUploads
  , setTorrentHandleMaxUploads
  , torrentHandleMaxConnections
  , setTorrentHandleMaxConnections
  , moveStorage
  , renameFile
  , superSeeding
  , infoHash
  , torrentFile
    -- ** TorrentStatus
  , TorrentState(..)
  , TorrentStatus(..)
  , getError
  , getSavePath
  , getName
  , getTorrentStatusNextAnnounce
  , getCurrentTracker
  , getTotalDownload
  , getTotalUpload
  , getTotalPayloadDownload
  , getTotalPayloadUpload
  , getTotalFailedBytes
  , getTotalRedundantBytes
  , getPieces
  , getVerifiedPieces
  , getTotalDone
  , getTotalWantedDone
  , getTotalWanted
  , getAllTimeUpload
  , getAllTimeDownload
  , getAddedTime
  , getCompletedTime
  , getLastSeenComplete
  , getProgress
  , getProgressPpm
  , getQueuePosition
  , getDownloadRate
  , getUploadRate
  , getDownloadPayloadRate
  , getUploadPayloadRate
  , getNumSeeds
  , getNumPeers
  , getNumComplete
  , getNumIncomplete
  , getListSeeds
  , getListPeers
  , getConnectCandidates
  , getNumPieces
  , getDistributedFullCopies
  , getDistributedFraction
  , getDistributedCopies
  , getBlockSize
  , getNumUploads
  , getNumConnections
  , getUploadsLimit
  , getConnectionsLimit
  , getUpBandwidthQueue
  , getDownBandwidthQueue
  , getTimeSinceUpload
  , getTimeSinceDownload
  , getActiveTime
  , getFinishedTime
  , getSeedingTime
  , getSeedRank
  , getLastScrape
  , getPriority
  , getState
  , getNeedSaveResume
  , getIpFilterApplies
  , getUploadMode
  , getShareMode
  , getSuperSeeding
  , getPaused
  , getAutoManaged
  , getSequentialDownload
  , getIsSeeding
  , getIsFinished
  , getHasMetadata
  , getHasIncoming
  , getSeedMode
  , getMovingStorage
  , getTorrentStatusInfoHash
  -- ** AnnounceEntry
  , TrackerSource(..)
  , AnnounceEntry(..)
  , newAnnounceEntry
  , nextAnnounceIn
  , minAnnounceIn
  , reset
  , canAnnounce
  , isWorking
  , trim
  , getAnnounceEntryUrl
  , setAnnounceEntryUrl
  , getAnnounceEntryTrackerid
  , setAnnounceEntryTrackerid
  , getMessage
  , setMessage
  , getLastError
  , getAnnounceEntryNextAnnounce
  , getMinAnnounce
  , getScrapeIncomplete
  , getScrapeComplete
  , getScrapeDownloaded
  , getTier
  , getFailLimit
  , getFails
  , getUpdating
  , getSource
  , getVerified
  , getStartSent
  , getCompleteSent
  , getSendStats
  -- ** TorrentInfo
  , TorrentInfo(..)
  , newTorrentInfo
  , torrentInfoFromBuffer
  , torrentInfoFromInfoHash
  , files
  , origFiles
  , torrentInfoRenameFile
  , remapFiles
  , torrentInfoTrackers
  , torrentInfoAddTracker
    -- , similarTorrents
    -- , collections
  , totalSize
  , numPieces
  , pieceLength
  , torrentInfoInfoHash
  , numFiles
  , mapBlock
  , mapFile
    -- , unload
    -- , load
  , sslCert
  , torrentInfoIsValid
  , priv
  , isI2p
  , hashForPiece
  , pieceSize
    -- , isLoaded
  , merkleTree
  , setMerkleTree
  , creationDate
  , torrentInfoName
  , torrentInfoComment
  , torrentInfoCreator
  , torrentInfoMetadata
  , isMerkleTorrent
  -- * Bencoding
  , Bencoded
  , entryToBencoded
  , bencodedData
  -- * Standard Library
  , StdString
  , unStdString
  , stdStringToText
  , textToStdString
  , stdStringToByteString
  , byteStringToStdString
  , ErrorCode
  , newErrorCode
  , errorCodeValue
  , errorCodeMessage
  -- * Settings
  -- ** ProxySettings
  , ProxySettings(..)
  , ProxyType(..)
  , newProxySettings
  , getProxyHostname
  , setProxyHostname
  , getProxyUsername
  , setProxyUsername
  , getProxyPassword
  , setProxyPassword
  , getProxyType
  , setProxyType
  , getProxyPort
  , setProxyPort
  , getProxyHostnames
  , setProxyHostnames
  , getProxyPeerConnections
  , setProxyPeerConnections
  -- ** SessionSettings
  , SessionSettings
  , unSessionSettings
  , newSessionSettings
  , SuggestMode(..)
  , ChokingAlgorithm(..)
  , SeedChokingAlgorithm(..)
  , IoBufferMode(..)
  , DiskCacheAlgo(..)
  , BandwidthMixedAlgo(..)
  , getVersion
  , setVersion
  , getUserAgent
  , setUserAgent
  , getTrackerCompletionTimeout
  , setTrackerCompletionTimeout
  , getTrackerReceiveTimeout
  , setTrackerReceiveTimeout
  , getStopTrackerTimeout
  , setStopTrackerTimeout
  , getTrackerMaximumResponseLength
  , setTrackerMaximumResponseLength
  , getPieceTimeout
  , setPieceTimeout
  , getRequestTimeout
  , setRequestTimeout
  , getRequestQueueTime
  , setRequestQueueTime
  , getMaxAllowedInRequestQueue
  , setMaxAllowedInRequestQueue
  , getMaxOutRequestQueue
  , setMaxOutRequestQueue
  , getWholePiecesThreshold
  , setWholePiecesThreshold
  , getPeerTimeout
  , setPeerTimeout
  , getUrlseedTimeout
  , setUrlseedTimeout
  , getUrlseedPipelineSize
  , setUrlseedPipelineSize
  , getUrlseedWaitRetry
  , setUrlseedWaitRetry
  , getFilePoolSize
  , setFilePoolSize
  , getAllowMultipleConnectionsPerIp
  , setAllowMultipleConnectionsPerIp
  , getMaxFailcount
  , setMaxFailcount
  , getMinReconnectTime
  , setMinReconnectTime
  , getPeerConnectTimeout
  , setPeerConnectTimeout
  , getIgnoreLimitsOnLocalNetwork
  , setIgnoreLimitsOnLocalNetwork
  , getConnectionSpeed
  , setConnectionSpeed
  , getSendRedundantHave
  , setSendRedundantHave
  , getLazyBitfields
  , setLazyBitfields
  , getInactivityTimeout
  , setInactivityTimeout
  , getUnchokeInterval
  , setUnchokeInterval
  , getOptimisticUnchokeInterval
  , setOptimisticUnchokeInterval
  , getAnnounceIp
  , setAnnounceIp
  , getNumWant
  , setNumWant
  , getInitialPickerThreshold
  , setInitialPickerThreshold
  , getAllowedFastSetSize
  , setAllowedFastSetSize
  , getSuggestMode
  , setSuggestMode
  , getMaxQueuedDiskBytes
  , setMaxQueuedDiskBytes
  , getMaxQueuedDiskBytesLowWatermark
  , setMaxQueuedDiskBytesLowWatermark
  , getHandshakeTimeout
  , setHandshakeTimeout
  , getUseDhtAsFallback
  , setUseDhtAsFallback
  , getFreeTorrentHashes
  , setFreeTorrentHashes
  , getUpnpIgnoreNonrouters
  , setUpnpIgnoreNonrouters
  , getSendBufferLowWatermark
  , setSendBufferLowWatermark
  , getSendBufferWatermark
  , setSendBufferWatermark
  , getSendBufferWatermarkFactor
  , setSendBufferWatermarkFactor
  , getChokingAlgorithm
  , setChokingAlgorithm
  , getSeedChokingAlgorithm
  , setSeedChokingAlgorithm
  , getUseParoleMode
  , setUseParoleMode
  , getCacheSize
  , setCacheSize
  , getCacheBufferChunkSize
  , setCacheBufferChunkSize
  , getCacheExpiry
  , setCacheExpiry
  , getUseReadCache
  , setUseReadCache
  , getExplicitReadCache
  , setExplicitReadCache
  , getExplicitCacheInterval
  , setExplicitCacheInterval
  , getDiskIoWriteMode
  , setDiskIoWriteMode
  , getDiskIoReadMode
  , setDiskIoReadMode
  , getCoalesceReads
  , setCoalesceReads
  , getCoalesceWrites
  , setCoalesceWrites
  , getOutgoingPorts
  , setOutgoingPorts
  , getPeerTos
  , setPeerTos
  , getActiveDownloads
  , setActiveDownloads
  , getActiveSeeds
  , setActiveSeeds
  , getActiveDhtLimit
  , setActiveDhtLimit
  , getActiveTrackerLimit
  , setActiveTrackerLimit
  , getActiveLsdLimit
  , setActiveLsdLimit
  , getActiveLimit
  , setActiveLimit
  , getAutoManagePreferSeeds
  , setAutoManagePreferSeeds
  , getDontCountSlowTorrents
  , setDontCountSlowTorrents
  , getAutoManageInterval
  , setAutoManageInterval
  , getShareRatioLimit
  , setShareRatioLimit
  , getSeedTimeRatioLimit
  , setSeedTimeRatioLimit
  , getSeedTimeLimit
  , setSeedTimeLimit
  , getPeerTurnoverInterval
  , setPeerTurnoverInterval
  , getPeerTurnover
  , setPeerTurnover
  , getPeerTurnoverCutoff
  , setPeerTurnoverCutoff
  , getCloseRedundantConnections
  , setCloseRedundantConnections
  , getAutoScrapeInterval
  , setAutoScrapeInterval
  , getAutoScrapeMinInterval
  , setAutoScrapeMinInterval
  , getMaxPeerlistSize
  , setMaxPeerlistSize
  , getMaxPausedPeerlistSize
  , setMaxPausedPeerlistSize
  , getMinAnnounceInterval
  , setMinAnnounceInterval
  , getPrioritizePartialPieces
  , setPrioritizePartialPieces
  , getAutoManageStartup
  , setAutoManageStartup
  , getRateLimitIpOverhead
  , setRateLimitIpOverhead
  , getAnnounceToAllTrackers
  , setAnnounceToAllTrackers
  , getAnnounceToAllTiers
  , setAnnounceToAllTiers
  , getPreferUdpTrackers
  , setPreferUdpTrackers
  , getStrictSuperSeeding
  , setStrictSuperSeeding
  , getSeedingPieceQuota
  , setSeedingPieceQuota
  , getMaxSparseRegions
  , setMaxSparseRegions
  , getLockDiskCache
  , setLockDiskCache
  , getMaxRejects
  , setMaxRejects
  , getRecvSocketBufferSize
  , setRecvSocketBufferSize
  , getSendSocketBufferSize
  , setSendSocketBufferSize
  , getOptimizeHashingForSpeed
  , setOptimizeHashingForSpeed
  , getFileChecksDelayPerBlock
  , setFileChecksDelayPerBlock
  , getDiskCacheAlgorithm
  , setDiskCacheAlgorithm
  , getReadCacheLineSize
  , setReadCacheLineSize
  , getWriteCacheLineSize
  , setWriteCacheLineSize
  , getOptimisticDiskRetry
  , setOptimisticDiskRetry
  , getDisableHashChecks
  , setDisableHashChecks
  , getAllowReorderedDiskOperations
  , setAllowReorderedDiskOperations
  , getAllowI2pMixed
  , setAllowI2pMixed
  , getMaxSuggestPieces
  , setMaxSuggestPieces
  , getDropSkippedRequests
  , setDropSkippedRequests
  , getLowPrioDisk
  , setLowPrioDisk
  , getLocalServiceAnnounceInterval
  , setLocalServiceAnnounceInterval
  , getDhtAnnounceInterval
  , setDhtAnnounceInterval
  , getUdpTrackerTokenExpiry
  , setUdpTrackerTokenExpiry
  , getVolatileReadCache
  , setVolatileReadCache
  , getGuidedReadCache
  , setGuidedReadCache
  , getDefaultCacheMinAge
  , setDefaultCacheMinAge
  , getNumOptimisticUnchokeSlots
  , setNumOptimisticUnchokeSlots
  , getNoAtimeStorage
  , setNoAtimeStorage
  , getDefaultEstReciprocationRate
  , setDefaultEstReciprocationRate
  , getIncreaseEstReciprocationRate
  , setIncreaseEstReciprocationRate
  , getDecreaseEstReciprocationRate
  , setDecreaseEstReciprocationRate
  , getIncomingStartsQueuedTorrents
  , setIncomingStartsQueuedTorrents
  , getReportTrueDownloaded
  , setReportTrueDownloaded
  , getStrictEndGameMode
  , setStrictEndGameMode
  , getBroadcastLsd
  , setBroadcastLsd
  , getEnableOutgoingUtp
  , setEnableOutgoingUtp
  , getEnableIncomingUtp
  , setEnableIncomingUtp
  , getEnableOutgoingTcp
  , setEnableOutgoingTcp
  , getEnableIncomingTcp
  , setEnableIncomingTcp
  , getMaxPexPeers
  , setMaxPexPeers
  , getIgnoreResumeTimestamps
  , setIgnoreResumeTimestamps
  , getNoRecheckIncompleteResume
  , setNoRecheckIncompleteResume
  , getAnonymousMode
  , setAnonymousMode
  , getForceProxy
  , setForceProxy
  , getTickInterval
  , setTickInterval
  , getReportWebSeedDownloads
  , setReportWebSeedDownloads
  , getShareModeTarget
  , setShareModeTarget
  , getUploadRateLimit
  , setUploadRateLimit
  , getDownloadRateLimit
  , setDownloadRateLimit
  , getLocalUploadRateLimit
  , setLocalUploadRateLimit
  , getLocalDownloadRateLimit
  , setLocalDownloadRateLimit
  , getDhtUploadRateLimit
  , setDhtUploadRateLimit
  , getUnchokeSlotsLimit
  , setUnchokeSlotsLimit
  , getHalfOpenLimit
  , setHalfOpenLimit
  , getSessionConnectionsLimit
  , setSessionConnectionsLimit
  , getConnectionsSlack
  , setConnectionsSlack
  , getUtpTargetDelay
  , setUtpTargetDelay
  , getUtpGainFactor
  , setUtpGainFactor
  , getUtpMinTimeout
  , setUtpMinTimeout
  , getUtpSynResends
  , setUtpSynResends
  , getUtpFinResends
  , setUtpFinResends
  , getUtpNumResends
  , setUtpNumResends
  , getUtpConnectTimeout
  , setUtpConnectTimeout
  , getUtpDynamicSockBuf
  , setUtpDynamicSockBuf
  , getUtpLossMultiplier
  , setUtpLossMultiplier
  , getMixedModeAlgorithm
  , setMixedModeAlgorithm
  , getRateLimitUtp
  , setRateLimitUtp
  , getListenQueueSize
  , setListenQueueSize
  , getAnnounceDoubleNat
  , setAnnounceDoubleNat
  , getTorrentConnectBoost
  , setTorrentConnectBoost
  , getSeedingOutgoingConnections
  , setSeedingOutgoingConnections
  , getNoConnectPrivilegedPorts
  , setNoConnectPrivilegedPorts
  , getAlertQueueSize
  , setAlertQueueSize
  , getMaxMetadataSize
  , setMaxMetadataSize
  , getSmoothConnects
  , setSmoothConnects
  , getAlwaysSendUserAgent
  , setAlwaysSendUserAgent
  , getApplyIpFilterToTrackers
  , setApplyIpFilterToTrackers
  , getReadJobEvery
  , setReadJobEvery
  , getUseDiskReadAhead
  , setUseDiskReadAhead
  , getLockFiles
  , setLockFiles
  , getSslListen
  , setSslListen
  , getTrackerBackoff
  , setTrackerBackoff
  , getBanWebSeeds
  , setBanWebSeeds
  , getMaxHttpRecvBufferSize
  , setMaxHttpRecvBufferSize
  , getSupportShareMode
  , setSupportShareMode
  , getSupportMerkleTorrents
  , setSupportMerkleTorrents
  , getReportRedundantBytes
  , setReportRedundantBytes
  , getHandshakeClientVersion
  , setHandshakeClientVersion
  , getUseDiskCachePool
  , setUseDiskCachePool
  , getInactiveDownRate
  , setInactiveDownRate
  , getInactiveUpRate
  , setInactiveUpRate
    -- ** DhtSettings
  , DhtSettings
  , unDhtSettings
  , newDhtSettings
  , getMaxPeersReply
  , setMaxPeersReply
  , getSearchBranching
  , setSearchBranching
  , getMaxFailCount
  , setMaxFailCount
  , getMaxTorrents
  , setMaxTorrents
  , getMaxDhtItems
  , setMaxDhtItems
  , getMaxTorrentSearchReply
  , setMaxTorrentSearchReply
  , getRestrictRoutingIps
  , setRestrictRoutingIps
  , getRestrictSearchIps
  , setRestrictSearchIps
  , getExtendedRoutingTable
  , setExtendedRoutingTable
  , getAggressiveLookups
  , setAggressiveLookups
  , getPrivacyLookups
  , setPrivacyLookups
  , getEnforceNodeId
  , setEnforceNodeId
  , getIgnoreDarkInternet
  , setIgnoreDarkInternet
  , minMemoryUsage
  , highPerformanceSeed
    -- ** PeSettings
  , PeSettings
  , PeEncPolicy(..)
  , PeEncLevel(..)
  , unPeSettings
  , newPeSettings
  , getOutEncPolicy
  , setOutEncPolicy
  , getInEncPolicy
  , setInEncPolicy
  , getAllowedEncLevel
  , setAllowedEncLevel
  , getPreferRc4
  , setPreferRc4
  -- * Plugins
  , utMetadataPlugin
  , utPexPlugin
  , smartBanPlugin
  , ltTrackersPlugin
  -- * Alerts
  -- ** Alerts handling
  , AlertHandler(..)
  , handleAlert
  , handleAlerts
  , sessionHandleAlerts
  -- ** Alerts
  , IsAlert(..)
  , IsTorrentAlert(..)
  , IsTrackerAlert(..)
  , IsPeerAlert(..)
  , Alert
  , AlertCategory(..)
  , PerformanceWarning(..)
  , AnnounceEvent(..)
  , SocketType(..)
  , ListenOp(..)
  , BlockedReason(..)
  , StatsChannel(..)
  , AnonymousModeKind(..)
  , RssState(..)
  , IncomingSocketType(..)
  , DhtOperation(..)
  , TorrentAlert(..)
  , PeerAlert(..)
  , TrackerAlert(..)
  , TorrentAddedAlert(..)
  , TorrentRemovedAlert(..)
  , ReadPieceAlert(..)
  , FileCompletedAlert(..)
  , FileRenamedAlert(..)
  , FileRenameFailedAlert(..)
  , PerformanceAlert(..)
  , StateChangedAlert(..)
  , TrackerErrorAlert(..)
  , TrackerWarningAlert(..)
  , ScrapeReplyAlert(..)
  , ScrapeFailedAlert(..)
  , TrackerReplyAlert(..)
  , DhtReplyAlert(..)
  , TrackerAnnounceAlert(..)
  , HashFailedAlert(..)
  , PeerBanAlert(..)
  , PeerUnsnubbedAlert(..)
  , PeerSnubbedAlert(..)
  , PeerErrorAlert(..)
  , PeerConnectAlert(..)
  , PeerDisconnectedAlert(..)
  , InvalidRequestAlert(..)
  , TorrentFinishedAlert(..)
  , PieceFinishedAlert(..)
  , RequestDroppedAlert(..)
  , BlockTimeoutAlert(..)
  , BlockFinishedAlert(..)
  , BlockDownloadingAlert(..)
  , UnwantedBlockAlert(..)
  , StorageMovedAlert(..)
  , StorageMovedFailedAlert(..)
  , TorrentDeletedAlert(..)
  , TorrentDeleteFailedAlert(..)
  , SaveResumeDataAlert(..)
  , SaveResumeDataFailedAlert(..)
  , TorrentPausedAlert(..)
  , TorrentResumedAlert(..)
  , TorrentCheckedAlert(..)
  , UrlSeedAlert(..)
  , FileErrorAlert(..)
  , MetadataFailedAlert(..)
  , MetadataReceivedAlert(..)
  , UdpErrorAlert(..)
  , ExternalIpAlert(..)
  , ListenFailedAlert(..)
  , ListenSucceededAlert(..)
  , PortmapErrorAlert(..)
  , PortmapAlert(..)
  , PortmapLogAlert(..)
  , FastresumeRejectedAlert(..)
  , PeerBlockedAlert(..)
  , DhtAnnounceAlert(..)
  , DhtGetPeersAlert(..)
  , StatsAlert(..)
  , CacheFlushedAlert(..)
  , AnonymousModeAlert(..)
  , LsdPeerAlert(..)
  , TrackeridAlert(..)
  , DhtBootstrapAlert(..)
  , TorrentErrorAlert(..)
  , TorrentNeedCertAlert(..)
  , IncomingConnectionAlert(..)
  , AddTorrentAlert(..)
  , StateUpdateAlert(..)
  , DhtErrorAlert(..)
  , DhtImmutableItemAlert(..)
  , DhtMutableItemAlert(..)
  , DhtPutAlert(..)
  , RssAlert(..)
  , RssItemAlert(..)
  , I2pAlert(..)
  , castAlert
  , newAlertDeque
  , alertTimestamp
  , alertCategory
  , getHandle
  , peerAlertIp
  , peerAlertPid
  , trackerAlertUrl
  , readPieceAlertEc
  , readPieceAlertPiece
  , readPieceAlertSize
  , fileCompletedAlertIndex
  , fileRenamedAlertIndex
  , fileRenameFailedAlertIndex
  , fileRenameFailedAlertError
  , alertMessage
  , readPieceAlertBuffer
  , performanceAlertWarningCode
  , stateChangedAlertState
  , stateChangedAlertPrevState
  , trackerErrorAlertTimesInRow
  , trackerErrorAlertStatusCode
  , trackerErrorAlertErrorCode
  , trackerErrorAlertMsg
  , trackerWarningAlertMsg
  , scrapeReplyAlertComplete
  , scrapeReplyAlertIncomplete
  , scrapeFailedAlertMsg
  , trackerReplyAlertNumPeers
  , dhtReplyAlertNumPeers
  , trackerAnnounceAlertEvent
  , hashFailedAlertPieceIndex
  , peerErrorAlertError
  , peerConnectAlertSocketType
  , peerDisconnectedAlertError
  , invalidRequestAlertRequest
  , pieceFinishedAlertPieceIndex
  , requestDroppedAlertBlockIndex
  , requestDroppedAlertPieceIndex
  , blockTimeoutAlertBlockIndex
  , blockTimeoutAlertPieceIndex
  , blockFinishedAlertBlockIndex
  , blockFinishedAlertPieceIndex
  , blockDownloadingAlertBlockIndex
  , blockDownloadingAlertPieceIndex
  , blockDownloadingAlertPeerSpeedmsg
  , unwantedBlockAlertBlockIndex
  , unwantedBlockAlertPieceIndex
  , storageMovedAlertPath
  , storageMovedFailedAlertError
  , torrentDeletedAlertInfoHash
  , torrentDeleteFailedAlertInfoHash
  , torrentDeleteFailedAlertError
  , saveResumeDataAlertResumeData
  , saveResumeDataFailedAlertError
  , urlSeedAlertMsg
  , urlSeedAlertUrl
  , fileErrorAlertError
  , fileErrorAlertFile
  , metadataFailedAlertError
  , udpErrorAlertError
  , externalIpAlertExternalAddress
  , listenFailedAlertEndpoint
  , listenFailedAlertError
  , listenFailedAlertOperation
  , listenFailedAlertSockType
  , listenSucceededAlertEndpoint
  , listenSucceededAlertSockType
  , portmapErrorAlertError
  , portmapErrorAlertMapType
  , portmapErrorAlertMapping
  , portmapAlertMapType
  , portmapAlertMapping
  , portmapAlertExternalPort
  , portmapLogAlertMsg
  , portmapLogAlertMapType
  , fastresumeRejectedAlertError
  , peerBlockedAlertIp
  , peerBlockedAlertReason
  , dhtAnnounceAlertIp
  , dhtAnnounceAlertPort
  , dhtAnnounceAlertInfoHash
  , dhtGetPeersAlertInfoHash
  , statsAlertTransferred
  , statsAlertInterval
  , anonymousModeAlertKind
  , anonymousModeAlertStr
  , trackeridAlertTrackerid
  , rssAlertHandle
  , rssAlertUrl
  , rssAlertState
  , rssAlertError
  , torrentErrorAlertError
  , torrentNeedCertAlertError
  , incomingConnectionAlertSocketType
  , incomingConnectionAlertIp
  , addTorrentAlertParams
  , addTorrentAlertError
  , stateUpdateAlertStatus
  , rssItemAlertHandle
  , rssItemAlertItem
  , dhtErrorAlertOperation
  , dhtErrorAlertError
  , dhtImmutableItemAlertTarget
  , dhtImmutableItemAlertItem
  , dhtMutableItemAlertKey
  , dhtMutableItemAlertSignature
  , dhtMutableItemAlertSalt
  , dhtMutableItemAlertSeq
  , dhtMutableItemAlertItem
  , dhtPutAlertPublicKey
  , dhtPutAlertSignature
  , dhtPutAlertSalt
  , dhtPutAlertSeq
  , dhtPutAlertTarget
  , i2pAlertError
  -- * Storage
  -- ** FileEntry
  , FileEntry(..)
  , getPath
  , getSymlinkPath
  , getOffset
  , getSize
  , getFileBase
  , getMtime
  , getFilehash
  , getPadFile
  , getHiddenAttribute
  , getExecutableAttribute
  , getSymlinkAttribute
  -- ** FileSlice
  , FileSlice(..)
  -- ** FileStorage
  , FileStorage(..)
  , FileStorageFlags(..)
  , FileFlags(..)
  , newFileStorage
  , getFileIndex
  , getFileSliceOffset
  , getFileSliceSize
  , fileStorageIsValid
  , reserve
  , addFile
  , addFileFromEntry
  , fileStorageRenameFile
  , fileStorageMapBlock
  , fileStorageMapFile
  , fileStorageNumFiles
  , fileEntryAt
  , fileStorageTotalSize
  , setFileStorageNumPieces
  , fileStorageNumPieces
  , setFileStoragePieceLength
  , fileStoragePieceLength
  , fileStoragePieceSize
  , setFileStorageName
  , fileStorageName
  , fileStorageOptimize
  , fileSize
  , fileStorageHash
  , fileName
  , fileOffset
  , fileStorageMtime
  , padFileAt
  , symlink
  , filePath
  , fileFlags
  , setFileBase
  , fileBase
  , fileIndexAtOffset
  -- * Session
  -- ** AddTorrentParams
  , AddTorrentParams
  , TorrentSrc(..)
  , AddTorrentFlags(..)
  , StorageMode(..)
  , unAddTorrentParams
  , newAddTorrentParams
  , setFlags
  , getFlags
  , setTorrentName
  , getTorrentName
  , setTorrentSavePath
  , getTorrentSavePath
  , getTrackers
  , setTrackers
  , getUrlSeeds
  , setUrlSeeds
  , getResumeData
  , setResumeData
  , getStorageMode
  , setStorageMode
  , getFilePriorities
  , setFilePriorities
  , getTrackerid
  , setTrackerid
  , getUrl
  , setUrl
  , getUuid
  , setUuid
  , getSourceFeedUrl
  , setSourceFeedUrl
  , getInfoHash
  , setInfoHash
  , getMaxUploads
  , setMaxUploads
  , getMaxConnections
  , setMaxConnections
  , getUploadLimit
  , setUploadLimit
  , getDownloadLimit
  , setDownloadLimit
    -- ** Session
  , Session
  , DhtItemKey(..)
  , newDhtItemKey
  , SaveStateFlags(..)
  , ListenOnFlags(..)
  , RemoveTorrentOptions(..)
  , SessionFlags(..)
  , ProtocolType(..)
  , newSession
  , addTorrent
  , asyncAddTorrent
  , popAlerts
  , unSession
  , postTorrentUpdates
  , findTorrent
  , getTorrents
  , sessionResume
  , sessionPause
  , isPaused
  , isDhtRunning
  , startDht
  , stopDht
  , addDhtRouter
  , addDhtNode
  , dhtGetItem
  , dhtGetItem'
  , loadCountryDb
  , loadAsnumDb
  , sessionId
  , setPeerId
  , setKey
  , listenOn
  , isListening
  , listenPort
  , sslListenPort
  , removeTorrent
  , setAlertMask
    -- , setAlertDispatch
  , stopLsd
  , startLsd
  , stopUpnp
  , startUpnp
  , deletePortMapping
  , stopNatpmp
  , startNatpmp
  , loadState
  , saveState
  , refreshTorrentStatus
  , getTorrentStatus
  , sessionStatus
  , addFeed
  , removeFeed
  , getFeeds
  , getDhtSettings
  , setDhtSettings
  , getPeSettings
  , setPeSettings
  , getSessionSettings
  , setSessionSettings
  , dhtPutItem
  , addExtension
  , addTorrentExtension
  , proxy
  , setProxy
  , i2pProxy
  , setI2pProxy
    -- ** SessionStatus
  , SessionStatus
  , unSessionStatus
  , UtpStatus
  , unUtpStatus
  , getHasIncomingConnections
  , getSessionUploadRate
  , getSessionDownloadRate
  , getSessionTotalDownload
  , getSessionTotalUpload
  , getSessionPayloadUploadRate
  , getSessionPayloadDownloadRate
  , getSessionTotalPayloadDownload
  , getSessionTotalPayloadUpload
  , getIpOverheadUploadRate
  , getIpOverheadDownloadRate
  , getTotalIpOverheadDownload
  , getTotalIpOverheadUpload
  , getDhtUploadRate
  , getDhtDownloadRate
  , getTotalDhtDownload
  , getTotalDhtUpload
  , getTrackerUploadRate
  , getTrackerDownloadRate
  , getTotalTrackerDownload
  , getTotalTrackerUpload
  , getSessionTotalRedundantBytes
  , getSessionTotalFailedBytes
  , getSessionNumPeers
  , getNumUnchoked
  , getAllowedUploadSlots
  , getSessionUpBandwidthQueue
  , getSessionDownBandwidthQueue
  , getUpBandwidthBytesQueue
  , getDownBandwidthBytesQueue
  , getOptimisticUnchokeCounter
  , getUnchokeCounter
  , getDiskWriteQueue
  , getDiskReadQueue
  , getDhtNodes
  , getDhtNodeCache
  , getDhtTorrents
  , getDhtGlobalNodes
  , getDhtTotalAllocations
  , getPeerlistSize
    -- UtpStatus
  , getNumIdle
  , getNumSynSent
  , getNumConnected
  , getNumFinSent
  , getNumCloseWait
  , getPacketLoss
  , getTimeout
  , getPacketsIn
  , getPacketsOut
  , getFastRetransmit
  , getPacketResend
  , getSamplesAboveTarget
  , getSamplesBelowTarget
  , getPayloadPktsIn
  , getPayloadPktsOut
  , getInvalidPktsIn
  , getRedundantPktsIn
  , getUtpStats
  -- * CreateTorrent
  , CreateTorrent(..)
  , createTorrent
  , createTorrentFromTorrentInfo
  , createTorrentGenerate
  , createTorrentFiles
  , createTorrentSetComment
  , createTorrentSetCreator
  , createTorrentSetHash
  , createTorrentSetFileHash
  , createTorrentAddUrlSeed
  , createTorrentAddHttpSeed
  , createTorrentAddNode
  , createTorrentAddTracker
  , createTorrentSetRootCert
  , createTorrentPriv
  , createTorrentSetPriv
  , createTorrentNumPieces
  , createTorrentPieceLength
  , createTorrentPieceSize
  , createTorrentMerkleTree
  , createTorrentSetPieceHashes
  -- * Exceptions
  , LibtorrentException(..)
  , withErrorCode
  , withLibtorrentException
  , exceptU
  , except
  -- * RSS
  -- ** FeedItem
  , FeedItem(..)
  , getFeedItemUrl
  , getFeedItemUuid
  , getFeedItemTitle
  , getFeedItemDescription
  , getFeedItemComment
  , getFeedItemCategory
  , getFeedItemSize
  , getFeedItemHandle
  , getFeedItemInfoHash
  -- ** FeedSettings
  , FeedSettings(..)
  , newFeedSettings
  , getFeedSettingsUrl
  , setFeedSettingsUrl
  , getFeedSettingsAutoDownload
  , setFeedSettingsAutoDownload
  , getFeedSettingsAutoMapHandles
  , setFeedSettingsAutoMapHandles
  , getFeedSettingsDefaultTtl
  , setFeedSettingsDefaultTtl
  , getFeedSettingsAddArgs
  , setFeedSettingsAddArgs
  -- ** FeedStatus
  , FeedStatus(..)
  , getFeedStatusUrl
  , getFeedStatusTitle
  , getFeedStatusDescription
  , getFeedStatusLastUpdate
  , getFeedStatusNextUpdate
  , getFeedStatusUpdating
  , getFeedStatusItems
  , getFeedStatusError
  , getFeedStatusTtl
  -- ** FeedHandle
  , FeedHandle(..)
  , updateFeed
  , getFeedStatus
  , setFeedSettings
  -- * Utility
  -- ** Bitfield
  , Bitfield(..)
  , bitfieldToBitArray
  , bitArrayToBitfield
  -- ** Sha1Hash
  , Sha1Hash
  , unSha1Hash
  , sha1HashSize
  , newSha1Hash
  , sha1HashToByteString
  -- ** BitFlags
  , BitFlags(..)
  -- ** ArrayLike
  , ArrayLike(..)
  , VectorLike(..)
  , foldMap
  , fold
  , toList
  , fromList
  ) where

import           Data.Text                                         (Text)
import qualified Data.Text                                         as T
import           Foreign.C.String                                  (peekCAString)
import qualified Language.C.Inline                                 as C
import qualified Language.C.Inline.Cpp                             as C
import qualified Language.C.Inline.Unsafe                          as CU
import           Prelude                                           hiding
                                                                    (foldMap)
import           System.IO.Unsafe                                  (unsafePerformIO)


import           Network.Libtorrent.Alert
import           Network.Libtorrent.Bencode
import           Network.Libtorrent.Bitfield
import           Network.Libtorrent.CreateTorrent
import           Network.Libtorrent.ErrorCode
import           Network.Libtorrent.Exceptions
import           Network.Libtorrent.Extensions
import           Network.Libtorrent.FileStorage
import           Network.Libtorrent.Inline                         (libtorrentCtx)
import           Network.Libtorrent.PeerInfo
import           Network.Libtorrent.PeerRequest
import           Network.Libtorrent.Rss
import           Network.Libtorrent.Session
import           Network.Libtorrent.Session.AddTorrentParams
import           Network.Libtorrent.Session.DhtSettings
import           Network.Libtorrent.Session.PeSettings
import           Network.Libtorrent.Session.ProxySettings
import           Network.Libtorrent.Session.SessionSettings
import           Network.Libtorrent.Session.SessionStatus
import           Network.Libtorrent.Sha1Hash
import           Network.Libtorrent.String
import           Network.Libtorrent.TorrentHandle
import           Network.Libtorrent.TorrentHandle.BlockInfo
import           Network.Libtorrent.TorrentHandle.PartialPieceInfo
import           Network.Libtorrent.TorrentHandle.TorrentStatus
import           Network.Libtorrent.TorrentInfo
import           Network.Libtorrent.TorrentInfo.AnnounceEntry
import           Network.Libtorrent.Types
import           Network.Libtorrent.Types.ArrayLike
import           Network.Libtorrent.Vectors                        ()

C.context libtorrentCtx

C.include "<libtorrent/version.hpp>"
C.using "namespace libtorrent"

version :: Text
version =
  T.pack . unsafePerformIO $ [CU.exp| const char * { version() }|] >>= peekCAString
