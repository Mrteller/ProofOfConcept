import UIKit

class ModeratorsListViewController: UIViewController, AlertDisplayer {
    private enum CellIdentifiers {
        static let list = "List"
    }
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var incrementalIndicatorSwitch: UISwitch!
    
    var site: String!
    
    private var viewModel: ModeratorsViewModel!
    
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.color = UIColor(named: "AccentColor")
        indicatorView.startAnimating()
        
        tableView.isHidden = true
        tableView.separatorColor = UIColor(named: "AccentColor")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        let request = ModeratorRequest.from(site: site)
        viewModel = ModeratorsViewModel(request: request, delegate: self)
        
        viewModel.fetchModerators()    
    }
    
    @IBAction func incrementalIndicatorSwitchChange() {
        tableView.reloadData()
    }
    
}

extension ModeratorsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return incrementalIndicatorSwitch.isOn ? viewModel.currentCount : viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list,
                                                 for: indexPath) as! ModeratorTableViewCell
        // 2
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.moderator(at: indexPath.row))
        }
        return cell
    }
}

extension ModeratorsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard incrementalIndicatorSwitch.isOn else { return }
        let triggerRow = Int(Double(tableView.numberOfRows(inSection: 0)) * 0.6)
        if indexPath.row == triggerRow {
            viewModel.fetchModerators()
        }
    }
}

extension ModeratorsListViewController: ModeratorsViewModelDelegate {
    func onFetchCompleted() {
        // 1
        if indicatorView.isAnimating {
            indicatorView.stopAnimating()
            tableView.isHidden = false
        }
        let lastRow = tableView.numberOfRows(inSection: 0)
        if lastRow < viewModel.totalCount {
        tableView.insertRows(at: (lastRow..<viewModel.currentCount).map { IndexPath(row: $0, section: 0) }, with: .automatic)
        }
    }
    
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        
        let title = NSLocalizedString("Warning", comment: "Alert title")
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert button"), style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}

extension ModeratorsListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !incrementalIndicatorSwitch.isOn else { return }
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchModerators()
        }
    }
}

private extension ModeratorsListViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
