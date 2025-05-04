import Foundation

public enum Server {
	case gopls
	
	public var scriptName: String {
		switch self {
		case .gopls:
			"gopls.sh"
		}
	}
}

public struct ServerScript {
	public let url: URL
	public let version: Int
	
	public init(url: URL, version: Int) {
		self.url = url
		self.version = version
	}
}

public struct ScriptRepository {
	/// The root URL for the server scripts.
	public static var url: URL? {
		let appSupportDir = FileManager.default.urls(
			for: .applicationSupportDirectory,
			in: .userDomainMask
		).first
		
		return appSupportDir?.appendingPathComponent("com.chimehq.LanguageServerScripts")
	}
	
	public static func url(for server: Server) -> ServerScript? {
		guard let baseURL = Self.url else {
			return nil
		}
		
		let scriptURL = baseURL.appendingPathComponent(server.scriptName)
		
		return ServerScript(url: scriptURL, version: 1)
	}
}
