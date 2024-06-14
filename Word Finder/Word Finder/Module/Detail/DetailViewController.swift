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
    private var partOfSpeechLabels: [WFLabel] = []
    private var meaningViews: [MeaningView] = []
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let wordLabel = WFLabel(
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .extraLargeTitle),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.5
    )
    
    private let phoneticLabel = WFLabel(
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .headline),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false,
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

// MARK: - DetailViewControllerProtocol Methods
extension DetailViewController: DetailViewControllerProtocol {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        addViews()
        setupConstraints()
        setupTtsButton()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(wordLabel)
        verticalStackView.addArrangedSubview(phoneticLabel)
        view.addSubview(ttsButton)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            synonymCollectionView.heightAnchor.constraint(equalToConstant: 162),
            
            ttsButton.heightAnchor.constraint(equalToConstant: 64),
            ttsButton.widthAnchor.constraint(equalToConstant: 64),
            ttsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ttsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
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
        verticalStackView.arrangedSubviews.forEach { view in
            if view is MeaningView || view is UIStackView {
                verticalStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        partOfSpeechLabels.removeAll()
        meaningViews.removeAll()
        horizontalStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        verticalStackView.addArrangedSubview(horizontalStackView)
        word.meanings?.forEach { meaning in
            let partOfSpeechLabel = WFLabel(
                text: meaning.partOfSpeech?.capitalized ?? "",
                textAlignment: .center,
                textColor: .label,
                font: .preferredFont(forTextStyle: .body),
                backgroundColor: .secondarySystemBackground,
                clipsToBounds: true,
                cornerRadius: 12,
                isUserInteractionEnabled: true
            )
            partOfSpeechLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(partOfSpeechLabelTapped(_:)))
            partOfSpeechLabel.addGestureRecognizer(tapGesture)
            horizontalStackView.addArrangedSubview(partOfSpeechLabel)
            partOfSpeechLabels.append(partOfSpeechLabel)
            
            let meaningView = MeaningView()
            meaningView.configure(partOfSpeech: meaning.partOfSpeech?.capitalized ?? "", definitions: meaning.definitions ?? [])
            meaningViews.append(meaningView)
            verticalStackView.addArrangedSubview(meaningView)
        }
        verticalStackView.addArrangedSubview(synonymCollectionView)
    }
    
    @objc private func partOfSpeechLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedLabel = sender.view as? WFLabel else { return }
        
        if selectedLabel.backgroundColor == .systemBlue {
            selectedLabel.backgroundColor = .secondarySystemBackground
            selectedLabel.textColor = .label
            if partOfSpeechLabels.allSatisfy({ $0.backgroundColor == .secondarySystemBackground }) {
                meaningViews.forEach { $0.isHidden = false }
            } else {
                meaningViews.forEach { meaningView in
                    meaningView.isHidden = !partOfSpeechLabels.contains { $0.backgroundColor == .systemBlue && $0.text == meaningView.partOfSpeech }
                }
            }
        } else {
            selectedLabel.backgroundColor = .systemBlue
            selectedLabel.textColor = .white
            meaningViews.forEach { meaningView in
                meaningView.isHidden = !partOfSpeechLabels.contains { $0.backgroundColor == .systemBlue && $0.text == meaningView.partOfSpeech }
            }
        }
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

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 3, height: 50)
    }
}
