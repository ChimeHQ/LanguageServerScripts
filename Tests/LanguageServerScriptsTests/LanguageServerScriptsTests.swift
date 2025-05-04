import Testing

import LanguageServerScripts

struct LanguageServerScriptsTests {
    @Test func testGoPlsScript() throws {
		let script = ScriptRepository.url(for: .gopls)
		
		#expect(script?.url.path().hasSuffix("com.chimehq.LanguageServerScripts/gopls.sh") == true)
    }
}
