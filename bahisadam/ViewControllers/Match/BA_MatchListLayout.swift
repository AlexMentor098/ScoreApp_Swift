//
//  BA_MatchListLayout.swift
//  bahisadam
//
//  Created by ilker özcan on 04/10/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

fileprivate let headerViewHeight: CGFloat = 50
fileprivate let cellHeight: CGFloat = 84
fileprivate let footerViewHeight: CGFloat = 24
fileprivate let headerTopSpace: CGFloat = 10

fileprivate struct SticySection {
	
	enum SticyTypes {
		case MOVING
		case STICY
		case ENDING
	}
	
	let sectionNumber: Int
	let type: SticyTypes
	let position: CGFloat
	let headerStart: CGFloat
}

class BA_MatchListLayout: UICollectionViewFlowLayout {

	// store attributes
	private var cachedAttributes = [UICollectionViewLayoutAttributes]()
	private var lastBounds: CGRect!
	
	var headerWidth: CGFloat {
		
		get {
			return self.collectionView!.bounds.size.width
		}
	}
	
	// calculate section status (moving start, sticy, moving end)
	fileprivate var currentSticySection: SticySection? {
		
		get {
			
			let currentContentOffset = collectionView!.contentOffset.y
			var retval: SticySection?
			let numberOfSections = collectionView!.numberOfSections
			
			for section in 0..<numberOfSections {
				
				let sectionStartPosition = getSectionStartPosition(section: section)
				let sectionFooterStartPosition = getSectionFooterStartPosition(section: section)
				let nextSectionExists = (section < (numberOfSections)) ? true : false
				
				// calculate header view in the moving start position
				var movingStartPosition = sectionStartPosition + headerTopSpace
				if(section > 0) {
					
					movingStartPosition -= headerTopSpace
				}
				
				// if moving start
				if(currentContentOffset < movingStartPosition) {
					
					var currentSectionPos = sectionStartPosition - currentContentOffset
					
					// if this is not first section header add previous section position
					if(section > 0) {
						
						currentSectionPos -= headerTopSpace
					}
					
					//print("currentSticySection 1 \(section) \(currentSectionPos)")
					retval = SticySection(sectionNumber: section, type: SticySection.SticyTypes.MOVING, position: currentSectionPos, headerStart: sectionStartPosition)
					break
				
					// if sticy
				}else if(currentContentOffset < (sectionFooterStartPosition - headerViewHeight)) {
					
					//print("currentSticySection 2 \(section) \(-headerTopSpace) \(currentContentOffset) \(sectionFooterStartPosition)")
					retval = SticySection(sectionNumber: section, type: SticySection.SticyTypes.STICY, position: -headerTopSpace, headerStart: sectionStartPosition)
					break
					
					// if next section exists calculate moving end status
				}else if(nextSectionExists) {
					
					let nextSectionStartPos = getSectionStartPosition(section: (section + 1))
					//print("nextSectionExists \(currentContentOffset) \(sectionFooterStartPosition) \(nextSectionStartPos)")
					
					// if position > footer and < next section status is moving end
					if(currentContentOffset >= (sectionFooterStartPosition - headerViewHeight) && currentContentOffset < (nextSectionStartPos - headerTopSpace)) {
						
						let currentSectionPos = (sectionFooterStartPosition - headerViewHeight - footerViewHeight) - currentContentOffset + headerTopSpace
						//print("currentSticySection 3 \(section) \(currentSectionPos) \(currentContentOffset) \(sectionFooterStartPosition)")
						retval = SticySection(sectionNumber: section, type: SticySection.SticyTypes.ENDING, position: currentSectionPos, headerStart: sectionStartPosition)
						break
					}
				}
			}
			
			return retval
		}
		
	}
	
	// calculate section header start position
	private func getSectionStartPosition(section: Int) -> CGFloat {
	
		var retval: CGFloat = 0
		
		for curSec in 0..<section {
			
			retval += (headerViewHeight + footerViewHeight)
			let cellCount = collectionView!.numberOfItems(inSection: curSec)
			retval += (CGFloat(cellCount) * cellHeight)
		}
		
		return retval
	}
	
	// calculate section footer start position
	private func getSectionFooterStartPosition(section: Int) -> CGFloat {
		
		var retval: CGFloat = 0
		
		for curSec in 0...section {
			
			if(curSec == section) {
				
				retval += headerViewHeight
				let cellCount = collectionView!.numberOfItems(inSection: curSec)
				retval += (CGFloat(cellCount) * cellHeight)
			}else{
				
				retval += (headerViewHeight + footerViewHeight)
				let cellCount = collectionView!.numberOfItems(inSection: curSec)
				retval += (CGFloat(cellCount) * cellHeight)
			}
		}
		
		return retval
	}
	
	// prepare attributes
	override func prepare() {
		
		cachedAttributes.removeAll(keepingCapacity: false)
		
		if(lastBounds == nil) {
			lastBounds = CGRect(x: 0, y: 0, width: collectionView!.bounds.width, height: collectionView!.bounds.height)
		}
		
		var y: CGFloat = 0
		var lastSection = -1
		var lastSectionEnding = false
		var sticySectionExists = false
		var headerIsSticy = false
		var currentSticySectionRef: SticySection?
		var contentStart: CGFloat = 0
		
		if let sticySection = currentSticySection {
			
			sticySectionExists = true
			currentSticySectionRef = sticySection
			
			switch sticySection.type {
			case .MOVING:
				
				if(lastSection == -1) {
					
					lastSection = sticySection.sectionNumber
				}
				let indexPath = IndexPath(item: 0, section: sticySection.sectionNumber)
				let sectionAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
				let sectionPosition = lastBounds.origin.y + sticySection.position
				sectionAttributes.frame = CGRect(x: 0, y: sectionPosition, width: headerWidth, height: headerViewHeight)
				//print("Header MOVING frame \(sectionAttributes.frame)")
				sectionAttributes.zIndex = 10
				y += (sectionPosition + headerViewHeight)
				cachedAttributes.append(sectionAttributes)
				
				break
			case .STICY:
				
				if(lastSection == -1) {
					
					lastSection = sticySection.sectionNumber
				}
				headerIsSticy = true
				let indexPath = IndexPath(item: 0, section: sticySection.sectionNumber)
				let sectionPosition = lastBounds.origin.y + sticySection.position
				let sectionAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
				sectionAttributes.frame = CGRect(x: 0, y: sectionPosition, width: headerWidth, height: headerViewHeight)
				//print("Header STICY frame \(sectionAttributes.frame)")
				sectionAttributes.zIndex = 10
				y += (headerViewHeight + sectionPosition)
				cachedAttributes.append(sectionAttributes)
				
				break
			case .ENDING:
				
				if(lastSection == -1) {
					
					lastSection = sticySection.sectionNumber
				}
				
				lastSectionEnding = true
				let indexPath = IndexPath(item: 0, section: sticySection.sectionNumber)
				let sectionAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
				let sectionPosition = lastBounds.origin.y + sticySection.position
				sectionAttributes.frame = CGRect(x: 0, y: sectionPosition, width: headerWidth, height: headerViewHeight)
				//print("Header ENDING frame \(sectionAttributes.frame)")
				sectionAttributes.zIndex = 10
				y += (headerViewHeight + sectionPosition)
				cachedAttributes.append(sectionAttributes)
				
				break
			}
		}else{
			lastSection = 0
		}
		
		if(sticySectionExists) {
			
			contentStart = currentSticySectionRef!.headerStart
		}
		
		//print("last section \(lastSection) section count \(collectionView!.numberOfSections) \(y) \(collectionView!.contentOffset.y) contentStart = \(contentStart)")
		
		for currentSection in lastSection..<collectionView!.numberOfSections {
			
			if(currentSection != lastSection) {
			
				let indexPath = IndexPath(item: 0, section: currentSection)
				let sectionAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
				sectionAttributes.frame = CGRect(x: 0, y: y, width: headerWidth, height: headerViewHeight)
				sectionAttributes.zIndex = 5
				//print("Header frame for section \(currentSection) \(sectionAttributes.frame)")
				y += headerViewHeight
				cachedAttributes.append(sectionAttributes)
			}
			
			if((y - lastBounds.origin.y) > lastBounds.size.height) {
				//print("break! 1 y = \(y) height \(lastBounds.size.height)")
				break
			}
			
			if(!lastSectionEnding || currentSection != lastSection) {
				
				if(currentSection == lastSection && headerIsSticy) {
					
					y -= (lastBounds.origin.y - contentStart)
				}
				
				for item in 0..<collectionView!.numberOfItems(inSection: currentSection) {
				
					if(y > (lastBounds.origin.y - cellHeight)) {
					
						let indexPath = IndexPath(item: item, section: currentSection)
						let sectionAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
						sectionAttributes.frame = CGRect(x: 8, y: y, width: headerWidth - 16, height: cellHeight)
						sectionAttributes.zIndex = 5
						//print("item frame for section \(currentSection) item \(item) \(sectionAttributes.frame)")
						y += cellHeight
						cachedAttributes.append(sectionAttributes)
					}else{
						y += cellHeight
						//print("continue item \(currentSection) item \(item) \(y)")
					}
				
					if((y - lastBounds.origin.y) > lastBounds.size.height) {
						//print("break! 2 y = \(y) height \(lastBounds.size.height)")
						break
					}
				}
			}
			
			if((y - lastBounds.origin.y) > lastBounds.size.height) {
				//print("break! 3 y = \(y) height \(lastBounds.size.height)")
				break
			}
			
			
			/*if(lastSectionEnding && currentSection == lastSection) {
				y -= headerTopSpace
			}*/
			
			let indexPath = IndexPath(item: 0, section: currentSection)
			let sectionAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: indexPath)
			sectionAttributes.frame = CGRect(x: 0, y: y, width: headerWidth, height: footerViewHeight)
			sectionAttributes.zIndex = 5
			//print("Footer frame for section \(currentSection) \(sectionAttributes.frame) \(y)")
			y += footerViewHeight
			cachedAttributes.append(sectionAttributes)
			
			if((y - lastBounds.origin.y) > lastBounds.size.height) {
				//print("break! 4 y = \(y) height \(lastBounds.size.height)")
				break
			}
		}
	}
	
	// return stored attributes
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		
		return cachedAttributes
	}
	
	// Return true so that the layout is continuously invalidated as the user scrolls
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		
		self.lastBounds = newBounds
		return true
	}
}
