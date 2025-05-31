import Cocoa
import InputMethodKit

extension azooKeyMacInputController {
    // MARK: - Settings and Menu Items

    func setupMenu() {
        self.zenzaiToggleMenuItem = NSMenuItem(title: "Zenzai（ニューラルかな漢字変換）", action: #selector(self.toggleZenzai(_:)), keyEquivalent: "")
        self.liveConversionToggleMenuItem = NSMenuItem(title: "ライブ変換", action: #selector(self.toggleLiveConversion(_:)), keyEquivalent: "")
        self.appMenu.addItem(self.zenzaiToggleMenuItem)
        self.appMenu.addItem(self.liveConversionToggleMenuItem)
        self.appMenu.addItem(NSMenuItem.separator())
        self.appMenu.addItem(NSMenuItem(title: "詳細設定を開く", action: #selector(self.openConfigWindow(_:)), keyEquivalent: ""))
        self.appMenu.addItem(NSMenuItem(title: "ユーザー辞書を編集する", action: #selector(self.openUserDictionaryEditor(_:)), keyEquivalent: ""))
        self.appMenu.addItem(NSMenuItem(title: "View on GitHub", action: #selector(self.openGitHubRepository(_:)), keyEquivalent: ""))
    }

    @objc private func toggleZenzai(_ sender: Any) {
        self.segmentsManager.appendDebugMessage("\(#line): toggleZenzai")
        let config = Config.ZenzaiIntegration()
        config.value = !self.zenzaiEnabled
        self.updateZenzaiToggleMenuItem(newValue: config.value)
    }

    func updateZenzaiToggleMenuItem(newValue: Bool) {
        self.zenzaiToggleMenuItem.state = newValue ? .on : .off
        self.zenzaiToggleMenuItem.title = "Zenzai（ニューラルかな漢字変換）"
        self.zenzaiToggleMenuItem.toolTip = newValue ?
            "Zenzaiが有効です。高精度なニューラル変換を使用しています。" :
            "Zenzaiが無効です。従来の変換エンジンを使用しています。"
    }

    @objc func toggleLiveConversion(_ sender: Any) {
        self.segmentsManager.appendDebugMessage("\(#line): toggleLiveConversion")
        let config = Config.LiveConversion()
        config.value = !self.liveConversionEnabled
        self.updateLiveConversionToggleMenuItem(newValue: config.value)
    }

    func updateLiveConversionToggleMenuItem(newValue: Bool) {
        self.liveConversionToggleMenuItem.state = newValue ? .on : .off
        self.liveConversionToggleMenuItem.title = "ライブ変換"
        self.liveConversionToggleMenuItem.toolTip = newValue ?
            "ライブ変換が有効です。入力中に自動で変換候補を表示します。" :
            "ライブ変換が無効です。スペースキーで変換候補を表示します。"
    }

    @objc func openGitHubRepository(_ sender: Any) {
        guard let url = URL(string: "https://github.com/ensan-hcl/azooKey-Desktop") else {
            return
        }
        NSWorkspace.shared.open(url)
    }

    @objc func openConfigWindow(_ sender: Any) {
        (NSApplication.shared.delegate as? AppDelegate)!.openConfigWindow()
    }

    @objc func openUserDictionaryEditor(_ sender: Any) {
        (NSApplication.shared.delegate as? AppDelegate)!.openUserDictionaryEditorWindow()
    }

    // MARK: - Application Support Directory
    func prepareApplicationSupportDirectory() {
        do {
            self.segmentsManager.appendDebugMessage("\(#line): Applicatiion Support Directory Path: \(self.segmentsManager.azooKeyMemoryDir)")
            try FileManager.default.createDirectory(at: self.segmentsManager.azooKeyMemoryDir, withIntermediateDirectories: true)
        } catch {
            self.segmentsManager.appendDebugMessage("\(#line): \(error.localizedDescription)")
        }
    }
}
