import os
from pyfiglet import figlet_format
from colorama import Fore,Style

def logo():
    logos  = figlet_format("FACEBOOK-SCAN")
    print(f"{Fore.YELLOW}{logos} {Style.RESET_ALL}")

logo()
def search_in_large_file(filename, name=None, surname=None, city=None):
    results = []
    match_count = 0
    
    print(f"\n🔍 Arama yapılıyor...")
    print(f"Ad: {name if name else 'Herhangi biri'}")
    print(f"Soyad: {surname if surname else 'Herhangi biri'}")
    print(f"Şehir: {city if city else 'Herhangi biri'}")
    print("-" * 50)
    
    try:
        with open(filename, 'r', encoding='utf-8') as file:
            for line_number, line in enumerate(file, 1):
                parts = line.strip().split(',')
                
                if len(parts) < 10:
                    continue
                
                current_name = parts[2] if len(parts) > 2 else ""
                current_surname = parts[3] if len(parts) > 3 else ""
                current_city = parts[8] if len(parts) > 8 else ""
                
                name_match = True
                surname_match = True
                city_match = True
                
                if name and name.lower() not in current_name.lower():
                    name_match = False
                
                if surname and surname.lower() not in current_surname.lower():
                    surname_match = False
                
                if city and city.lower() not in current_city.lower():
                    city_match = False
                
                if name_match and surname_match and city_match:
                    match_count += 1
                    
                    user_data = {
                        'id': parts[0] if len(parts) > 0 else "N/A",
                        'phone': parts[1] if len(parts) > 1 else "N/A",
                        'name': current_name,
                        'surname': current_surname,
                        'gender': parts[6] if len(parts) > 6 else "N/A",
                        'language': parts[7] if len(parts) > 7 else "N/A",
                        'city': current_city if current_city and current_city != "None" else "Belirtilmemiş",
                        'profile_url': parts[-1] if parts[-1].startswith('http') else "N/A",
                        'line_number': line_number
                    }
                    
                    results.append(user_data)
                    
                    # Sonucu ekrana yazdır
                    print(f"\n🎯 **EŞLEŞME #{match_count}**")
                    print(f"📋 Satır No: {line_number}")
                    print(f"👤 Ad-Soyad: {user_data['name']} {user_data['surname']}")
                    print(f"📞 Telefon: {user_data['phone']}")
                    print(f"🆔 ID: {user_data['id']}")
                    print(f"⚤ Cinsiyet: {user_data['gender']}")
                    print(f"🌍 Dil: {user_data['language']}")
                    print(f"🏙️ Şehir: {user_data['city']}")
                    print(f"🔗 Profil: {user_data['profile_url']}")
                    print("-" * 40)
        
        print(f"\n✅ **ARAMA TAMAMLANDI**")
        print(f"📊 Toplam eşleşme: {match_count}")
        
        if match_count == 0:
            print("❌ Hiç eşleşme bulunamadı.")
            
    except FileNotFoundError:
        print(f"❌ Hata: '{filename}' dosyası bulunamadı!")
    except Exception as e:
        print(f"❌ Bir hata oluştu: {e}")

def main():
    print("=" * 60)
    print("🔍 FACEBOOK VERİ ARAMA PROGRAMI")
    print("=" * 60)
    print("\n⚠️  Not: Arama yapmak istediğiniz alanları boş bırakabilirsiniz.")
    print("   (Boş bırakılan alanlar için filtre uygulanmaz)\n")
    
    filename = os.path.join(os.getcwd(),'Turkey.txt')
    
    print("Arama kriterlerini girin:")
    name = input("👤 Ad (boş bırakabilirsiniz): ").strip()
    surname = input("🔤 Soyad (boş bırakabilirsiniz): ").strip()
    city = input("🏙️  Şehir (boş bırakabilirsiniz): ").strip()
    
    if not name and not surname and not city:
        response = input("\n⚠️  Hiçbir arama kriteri girilmedi. Tüm kayıtları listelemek istiyor musunuz? (e/h): ")
        if response.lower() != 'e':
            print("❌ İşlem iptal edildi.")
            return
    
    print(f"\n⏳ Dosya okunuyor: {filename}")
    # print(f"📁 Dosya boyutu: {os.path.getsize(filename) / (1024*1024):.2f} MB")
    
    search_in_large_file(
        filename, 
        name if name else None, 
        surname if surname else None, 
        city if city else None
    )

if __name__ == "__main__":
    main()