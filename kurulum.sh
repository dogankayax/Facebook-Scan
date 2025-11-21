#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
NC='\033[0m' 

CHECK="✅"
WARNING="⚠️"
ERROR="❌"
INFO="ℹ️"
FOLDER="📁"
TRASH="🗑️"
SUCCESS="🎉"

echo -e "${PURPLE}${BOLD}"
echo "╔════════════════════════════════════════╗"
echo "║        ZIP BİRLEŞTİRİCİ SCRIPT        ║"
echo "║           Renkli Versiyon             ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${CYAN}${BOLD}${INFO} Parçalanmış dosyalar birleştiriliyor...${NC}"

if ls parcali_veri.* >/dev/null 2>&1; then
    echo -e "${GREEN}${CHECK} Parçalanmış dosyalar bulundu, birleştirme başlıyor...${NC}"
    
    echo -e "${BLUE}${BOLD}${FOLDER} Parçalar doğru sıralanıyor...${NC}"
    pieces=$(ls parcali_veri.z01 parcali_veri.z02 parcali_veri.z03 parcali_veri.z04 parcali_veri.z05 parcali_veri.z06 parcali_veri.zip 2>/dev/null)
    
    echo -e "${CYAN}Birleştirilecek parçalar:${NC}"
    for piece in $pieces; do
        if [ -f "$piece" ]; then
            size=$(du -h "$piece" | cut -f1)
            echo -e "  ${WHITE}•${NC} $piece ${YELLOW}($size)${NC}"
        fi
    done
    
    echo -e "${BLUE}${BOLD}Parçalar birleştiriliyor...${NC}"
    cat $pieces > Turkey.zip
    
    if [ -f "Turkey.zip" ]; then
        size=$(du -h Turkey.zip | cut -f1)
        echo -e "${GREEN}${CHECK} Turkey.zip başarıyla oluşturuldu ${YELLOW}${BOLD}- Boyut: $size${NC}"
    else
        echo -e "${RED}${ERROR} Turkey.zip oluşturulamadı!${NC}"
        exit 1
    fi
else
    echo -e "${RED}${ERROR} 'parcali_veri.*' dosyaları bulunamadı!${NC}"
    echo -e "${YELLOW}Kullanım: ./birlestir_color.sh${NC}"
    exit 1
fi

echo ""
echo -e "${CYAN}${BOLD}${UNDERLINE}Turkey.zip açılıyor...${NC}"

# ZIP dosyasını aç
if unzip -o Turkey.zip; then
    echo -e "${GREEN}${CHECK} Turkey.zip başarıyla açıldı${NC}"
else
    echo -e "${YELLOW}${WARNING} Unzip'ten çıkış kodu: $?${NC}"
fi

if [ -f "Turkey.txt" ]; then
    echo -e "${GREEN}${CHECK} Turkey.txt dosyası başarıyla çıkarıldı${NC}"
    turkey_size=$(du -h Turkey.txt | cut -f1)
    line_count=$(wc -l < Turkey.txt 2>/dev/null || echo "N/A")
    echo -e "${GREEN}  ↳ Boyut: ${BOLD}$turkey_size${NC}"
    echo -e "${GREEN}  ↳ Satır sayısı: ${BOLD}$line_count${NC}"
else
    echo -e "${RED}${ERROR} Turkey.txt oluşturulamadı!${NC}"
    echo -e "${YELLOW}Zip içeriği:${NC}"
    unzip -l Turkey.zip
    exit 1
fi

echo ""
echo -e "${YELLOW}${BOLD}${UNDERLINE}Temizlik işlemi...${NC}"

if rm -f Turkey.zip; then
    echo -e "${GREEN}${CHECK} Turkey.zip silindi ${TRASH}${NC}"
else
    echo -e "${RED}${ERROR} Turkey.zip silinemedi!${NC}"
fi

if rm -f parcali_veri.*; then
    echo -e "${GREEN}${CHECK} Parça dosyaları silindi ${TRASH}${NC}"
else
    echo -e "${RED}${ERROR} Parça dosyaları silinemedi!${NC}"
fi

echo ""
echo -e "${GREEN}${BOLD}"
echo "╔════════════════════════════════════════╗"
echo "║          İŞLEM TAMAMLANDI!            ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${CYAN}${BOLD}${SUCCESS} Son durum:${NC}"
echo -e "${WHITE}${BOLD}"
ls -lh Turkey.txt
echo -e "${NC}"

echo -e "${PURPLE}${BOLD}${INFO} İstatistikler:${NC}"
echo -e "  ${CYAN}•${NC} Dosya: ${WHITE}Turkey.txt${NC}"
echo -e "  ${CYAN}•${NC} Boyut: ${YELLOW}$(du -h Turkey.txt | cut -f1)${NC}"
echo -e "  ${CYAN}•${NC} Satır: ${YELLOW}$(wc -l < Turkey.txt 2>/dev/null || echo "N/A")${NC}"
echo -e "  ${CYAN}•${NC} Tarih: ${YELLOW}$(date)${NC}"

echo -e "\n${GREEN}${BOLD}${SUCCESS} Her şey hazır! Turkey.txt kullanıma hazır.${NC}"