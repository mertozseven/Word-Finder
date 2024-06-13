//
//  DetailViewController.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import UIKit
import AVFoundation

// MARK: - DetailViewControllerProtocol
protocol DetailViewControllerProtocol: AnyObject {
    func displayWordDetail(_ word: WordEntity)
    func displaySynonyms(_ synonyms: [SynonymEntity])
    func showAlert(alertTitle: String, message: String, buttonTitle: String)
    func setupView()
}

// MARK: - DetailViewController
final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: DetailPresenterProtocol!
    private var audioPlayer: AVPlayer?
    private var currentAudioURL: String?
    private var synonyms: [String] = []
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    
    private let wordLabel = WFLabel(
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .largeTitle),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.5
    )
    
    private let phoneticLabel = WFLabel(
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .headline),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.5
    )
    
    private let synonymsLabel = WFLabel(
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.5
    )
    
    private let ttsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "waveform"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 32
        button.backgroundColor = .systemBlue
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var synonymCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SynonymCell.self, forCellWithReuseIdentifier: SynonymCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

// MARK: - DetailViewControllerProtocol Methods
extension DetailViewController: DetailViewControllerProtocol {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        addViews()
        setupStackView()
        setupConstraints()
        setupTtsButton()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(wordLabel)
        stackView.addArrangedSubview(phoneticLabel)
        view.addSubview(ttsButton)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            synonymCollectionView.heightAnchor.constraint(equalToConstant: 162),
            
            ttsButton.heightAnchor.constraint(equalToConstant: 64),
            ttsButton.widthAnchor.constraint(equalToConstant: 64),
            ttsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ttsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
    }
    
    private func setupTtsButton() {
        ttsButton.addTarget(self, action: #selector(ttsButtonTapped), for: .touchUpInside)
    }
    
    @objc private func ttsButtonTapped() {
        guard let audioURLString = currentAudioURL, let audioURL = URL(string: audioURLString) else {
            print("Invalid audio URL")
            return
        }
        audioPlayer = AVPlayer(url: audioURL)
        audioPlayer?.play()
    }
    
    func displayWordDetail(_ word: WordEntity) {
        wordLabel.text = word.word?.capitalized
        phoneticLabel.text = word.phonetic
        title = word.word?.capitalized
        if let audioURL = word.phonetics?.first?.audio, !audioURL.isEmpty {
            currentAudioURL = audioURL
            ttsButton.isHidden = false
        } else {
            ttsButton.isHidden = true
        }
        
        stackView.arrangedSubviews.forEach { view in
            if view is MeaningView {
                stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        
        word.meanings?.forEach { meaning in
            let meaningView = MeaningView()
            meaningView.configure(partOfSpeech: meaning.partOfSpeech?.capitalized ?? "", definitions: meaning.definitions ?? [])
            stackView.addArrangedSubview(meaningView)
        }
        
        stackView.addArrangedSubview(synonymCollectionView)
    }
    
    func displaySynonyms(_ synonyms: [SynonymEntity]) {
        self.synonyms = synonyms.prefix(6).map { $0.word ?? "" }
        synonymCollectionView.reloadData()
    }
    
    func showAlert(alertTitle: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate Methods
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return synonyms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynonymCell.identifier, for: indexPath) as? SynonymCell else {
            return UICollectionViewCell()
        }
        cell.configure(synonym: synonyms[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSynonym = synonyms[indexPath.row]
        presenter.didSelectSynonym(selectedSynonym)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 3, height: 50)
    }
}
